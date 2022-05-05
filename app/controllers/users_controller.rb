# Controller methods for the 'User' table.
# Users are created by looking up username or email using EpiCAS's sheffield_ldap_lookup gem.
class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: %i[show edit update showECFs]

  # GET /users
  def index
    # uses Ransack gem to search by parameters provided in view
    @q = User.ransack(params[:q])
    @users = @q.result
  end
  
  # GET /users/1
  def show
    set_user
    set_user_modules
  end

  # GET /users/csv_upload
  def csv_upload
    render :csv_upload
  end

  # GET /users/1/showECFs
  def showECFs
    # retrieves all of a user's ECFs.
    @ecfs = @user.ecfs
  end

  # POST /users
  # Creates a user on login via LDAP.
  def create
    user = User.new(username: params[:user][:username])
    user.get_info_from_ldap
    user.save
  end

  # POST /users
  def new
    @user = User.new
  end

  # PATCH/PUT /users/1
  # update a user's field via permitted parameters
  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # Generate a user using only their email - fill detail fields using LDAP.
  def ldap_user
    user = User.new(email: params[:email])
    user.get_info_from_ldap
    if user.username.nil?
      redirect_to new_user_path, alert: "User could not be found with email #{params[:email]}"
    elsif User.exists?(username: user.username)
      redirect_to new_user_path, alert: 'This user already exists in the database.'
    else
      user.role = params[:role]
      user.save
      redirect_to users_path, notice: "User was successfully created with role #{params[:role]}."
    end
  end

  # Method for CSV submission of /users/csv_upload
  # Accepts an uploaded .csv file, creates users in the 'email' column if they do not yet exist
  # Assigns modules in the 'module_code' column to their corresponding user
  def import
    path = params[:user][:file].tempfile.path
    users = []
    user_modules = []

    # hash of existing users and their ids {"email1@test.com => 23"}
    users_hash = User.pluck(:email, :id).to_h
    # hash of existing users and their module codes {"email1@test.com" => ["COM1004", "COM1010"]}
    user_modules_array = UserModule.select(:user_id, 'array_agg(module_code)').group(:user_id).pluck(:user_id, 'array_agg(module_code)')
    user_modules_hash = Hash[*user_modules_array.flatten(1)]

    new_users_hash = {}
    new_user_modules_hash = Hash.new { |x, y| x[y] = [] }

    headers = CSV.read(path, headers: true).headers
    # checks the CSV has the correct columns.
    if headers.include?('email') and headers.include?('module_code')
      CSV.foreach(path, headers: true) do |row|
        email = row.to_h['email']
        module_code = row.to_h['module_code']

        # importing users
        if users_hash.key?(email)
          # if the user already exists in the database, set them as the current user
          user = User.find_by(email: email)
        elsif new_users_hash.key?(email)
          # sets current user if already added by a previous table row
          user = new_users_hash[email]
        else
          # otherwise, import the user with LDAP details
          user = User.new(email: email, role: 2)
          user.get_info_from_ldap
          unless user.username.nil?
            new_users_hash[email] = user
            users << user
          end
        end

        # importing user modules that are not already assigned
        unless user_modules_hash[user.id.to_s]&.include? module_code or new_user_modules_hash[email]&.include? module_code
          new_user_modules_hash[email] << module_code
          unless user.username.nil? or module_code.nil?
            user_module = UserModule.new(module_code: module_code, user: user)
            user_modules << user_module
          end
        end
      end
      # import using the above arrays in batches.
      User.import users, batch_size: 2000
      UserModule.import user_modules, batch_size: 1000

      redirect_to users_path, notice: 'Users imported successfully.'
    else
      redirect_to users_path, alert: 'Failed to upload users - CSV file is of the incorrect format.'
    end
  end

  # null method - used for authorization of guest role priviliges
  def guest_prompt
    # null
  end

  private
  # sets @user variable for use in views
  def set_user
    @user = User.find(params[:id])
  end

  # sets @user_modules variable for use in views.
  def set_user_modules
    @user_modules = @user.user_modules
  end

  # sets permitted parameters used to update / create a user.
  def user_params
    params
      .require(:user)
      # permit changes to a user's role, and add related UserModule entries.
      .permit(:role, user_modules_attributes: %i[id user_id module_code _destroy])
  end
end

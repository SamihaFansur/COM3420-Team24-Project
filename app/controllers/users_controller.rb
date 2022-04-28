class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only:  [:show, :edit, :update, :showECFs]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result
  end

  def create
    user = User.new(username: params[:user][:username])
    user.get_info_from_ldap
    user.save
  end

  def show
    set_user
    set_user_modules
  end

  # Generates a user using only their email.
  def ldap_user
    user = User.new(email: params[:email])
    user.get_info_from_ldap
    if user.username.nil?
      redirect_to new_user_path, alert: "User could not be found with email #{params[:email]}"
    elsif User.exists?(username: user.username)
      redirect_to new_user_path, alert: "This user already exists in the database."
    else 
      user.role = params[:role]
      user.save
      redirect_to users_path, notice: "User was successfully created with role #{params[:role]}."
    end
  end

  def csv_upload
    puts "csv upload"
    render :csv_upload
  end

  def import
    path = params[:user][:file].tempfile.path
    users = []
    user_modules = []

    # hash of existing users and their ids {"email1@test.com => 23"}
    users_hash = User.pluck(:email, :id).to_h
    # hash of existing users and their module codes {"email1@test.com" => ["COM1004", "COM1010"]}
    user_modules_array = UserModule.select(:user_id, 'array_agg(module_code)').group(:user_id).pluck(:user_id, 'array_agg(module_code)')
    user_modules_hash = Hash[*user_modules_array.flatten(1)]

    new_users_hash = Hash.new
    new_user_modules_hash = Hash.new {|x,y| x[y] = []}

    headers = CSV.read(path, headers: true).headers
    if headers.include?("email") and headers.include?("module_code")
      CSV.foreach(path, headers: true) do |row|
        email = row.to_h["email"]
        module_code = row.to_h["module_code"]
  
        # importing users
        if users_hash.key?(email)
          # if the user already exists in the database, set them as the current user
          user = User.find_by(email: email)
        else
          # otherwise, import the user with LDAP details, unless added by a previous row
          unless new_users_hash.key?(email)
            user = User.new(email: email, role: 2)
            user.get_info_from_ldap
            unless user.username.nil?
              new_users_hash[email] = user
              users << user
            end
          else
            user = new_users_hash[email]
          end
        end
  
        # importing user modules
        unless user_modules_hash[user.id.to_s]&.include? module_code or new_user_modules_hash[email]&.include? module_code
          new_user_modules_hash[email] << module_code
          unless user.username.nil? or module_code.nil?
            user_module = UserModule.new(module_code: module_code, user: user)
            user_modules << user_module
          end
        end
      end
  
      User.import users, batch_size: 2000
      UserModule.import user_modules, batch_size: 1000
  
      redirect_to users_path, notice: "Users imported successfully."  
    else
      redirect_to users_path, alert: "Failed to upload users - CSV file is of the incorrect format."
    end
    
  end

  def showECFs
    @ecfs = @user.ecfs
  end

  def new
    @user = User.new
    # user.modules.build here?
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def set_user_modules
      @user_modules = @user.user_modules
    end
    
    # incomplete method. admin should only add/edit/remove modules
    # and update 'role' enum (once we have this)
    def user_params
      params
        .require(:user)
        .permit(:role, user_modules_attributes: [:id, :user_id, :module_code, :_destroy])
    end
end
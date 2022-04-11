class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only:  [:show, :edit, :update]

  def index
    @users = User.all
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
      # render :new
      redirect_to new_user_path, alert: "User could not be found with email #{params[:email]}"
    elsif User.exists?(username: user.username)
      redirect_to new_user_path, alert: "This user already exists in the database."
    else 
      user.role = params[:role]
      user.save
      redirect_to users_path, notice: "User was successfully created wtih role #{params[:role]}."
    end
  end

  def csv_upload
    puts "csv upload"
    render :csv_upload
  end

  def import
    path = params[:user][:file].tempfile.path
    # new users to commit to the database
    users = []
    # new user_modules to commit to the database
    user_modules = []

    # hash of existing users and their ids {"email1@test.com => 23"}
    users_hash = User.pluck(:email, :id).to_h
    # hash of existing users and their module codes {"email1@test.com" => ["COM1004", "COM1010"]}
    user_modules_array = UserModule.select(:user_id, 'array_agg(module_code)').group(:user_id).pluck(:user_id, 'array_agg(module_code)')
    user_modules_hash = Hash[*user_modules_array.flatten(1)]
    # hash to track new users from csv {"email3@test.com => User#{...}"}
    new_users_hash = Hash.new
    # hash to track new user modules from csv {"email3" => ["COM2003", "COM3004"]}
    new_user_modules_hash = Hash.new {|x,y| x[y] = []}

    #basic. does repeat existing users
    CSV.foreach(path, headers: true) do |row|
      email = row.to_h["email"]
      module_code = row.to_h["module_code"]

      unless email.nil?
        # if the user already exists in the database
        if users_hash.key?(email)
          user = User.find_by(email: email)
          # user.get_info_from_ldap
          
          # only tries 'include' if user has any modules
          if user_modules_hash.key?(user.id.to_s)
            unless user_modules_hash[user.id.to_s].include? module_code or new_user_modules_hash[email].include? module_code
              new_user_modules_hash[email] << module_code
              user_module = UserModule.new(module_code: module_code, user: user)
              user_modules << user_module
            end
          else
            unless new_user_modules_hash[email].include? module_code
              new_user_modules_hash[email] << module_code
              user_module = UserModule.new(module_code: module_code, user: user)
              user_modules << user_module
            end
          end
        else
          # only add queue this user for creation if not added by a previous row
          unless new_users_hash.key?(email)
            user = User.new(email: email, role: 2)
            user.get_info_from_ldap
            new_users_hash[email] = user
            users << user
          else
            user = new_users_hash[email]
          end

          # only add module if not added by a previous row
          if new_user_modules_hash.key?(email)
            unless new_user_modules_hash[email].include? module_code
              new_user_modules_hash[email] << module_code
              user_module = UserModule.new(module_code: module_code, user: user)
              user_modules << user_module
            end
          else
            new_user_modules_hash[email] << module_code
            user_module = UserModule.new(module_code: module_code, user: user)
            user_modules << user_module
          end
        end
      end
    end

    User.import users, batch_size: 2000
    UserModule.import user_modules, batch_size: 1000

    redirect_to users_path, notice: "Users imported successfully."
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
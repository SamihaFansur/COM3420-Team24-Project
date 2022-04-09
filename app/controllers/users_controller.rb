class UsersController < ApplicationController
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
    columns = ["email"]
    path = params[:user][:file].tempfile.path
    users = []
    user_modules = []

    lists_hash = UserModule.pluck(:module_code, :id).to_h
    CSV.foreach(path, headers: true) do |row|
      unless row.to_h["email"].nil?
        user = User.new(email: row.to_h["email"], role: 2)
        user.get_info_from_ldap
        users << user unless user.username.nil?
        if lists_hash.has_key?(row.to_h["module_code"])
          user_module = UserModule.where(module_code: row.to_h["module_code"])
          user_module.user_id = user.id
          user_modules << user_module
        else
          user_module = UserModule.new(module_code: row.to_h["module_code"], user_id: user.id)
          user_modules << user_module
        end
      end
    end
    puts user_modules
    # User.import users, batch_size: 2000
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
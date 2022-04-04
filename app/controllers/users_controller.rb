class UsersController < ApplicationController
  before_action :set_user, only:  [:show, :edit, :update]

  def index
    @users = User.all
  end

  def create
    user = User.new(username: params[:user][:username])
    user.get_info_from_ldap
    user.save
    print("-----------") #doesnt print these so is it using this method?yes cz ldap works but y dont these lines print????
    print("user saved")
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
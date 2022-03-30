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
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    # incomplete method. admin should only add/edit/remove modules
    # and update 'role' enum (once we have this)
    def user_params
      params
        .require(:user)
    end
end
class LoginController < ApplicationController
  before_action { @current_nav_identifier = :login }
  before_action :authenticate_user!, only: [:login]


  def login
    @current_nav_identifier = :login
  end
end

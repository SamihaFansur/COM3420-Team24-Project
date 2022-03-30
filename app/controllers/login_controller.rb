class LoginController < ApplicationController
  before_action { @current_nav_identifier = :login }
  before_action :authenticate_user!, only: [:login]


  def login
    @current_nav_identifier = :login
    print("---------------")
    print(@current_nav_identifier)
  end
end

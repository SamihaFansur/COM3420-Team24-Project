class UsersController < ApplicationController

    def create
        user = User.new(username: params[:user][:username])
        user.get_info_from_ldap
        user.save
        print("-----------") #doesnt print these so is it using this method?yes cz ldap works but y dont these lines print????
        print("user saved") 
    end



end
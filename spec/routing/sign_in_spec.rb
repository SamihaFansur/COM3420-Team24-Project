require_relative "../spec_helper"
require 'rails_helper'


describe 'Sign in specs' do
  before do
      allow_any_instance_of(User).to receive(:get_info_from_ldap) do |user|

          user.uid = 'ac1arx'
          user.email = 'a.ragni@sheffield.ac.uk'
          user.username = 'ac1arx'
          user.dn = 'uid=aca20sf,ou=Undergraduates,ou=Students,ou=Users,dc=sheffield,dc=ac,dc=uk'
      end
      # allow_any_instance_of(User).to receive(:get_info_from_ldap).and_return(true)

  end
  describe ApplicationController, :type => :controller do


    controller(ApplicationController) do
      def after_sign_in_path_for(resource)
          super resource
      end
    end

    # describe "After sign-up" do
    #   it "redirects student to ecf page" do
    #       @user = login_as(FactoryBot.create(:admin))
    #       controller.after_sign_in_path_for(@user).should == ecfs_path
    #   end
    # end
  end

end

require_relative "../spec_helper"

#Test Login

describe "the page links" do
    #log in as a user
    it "ECF is accessible from the login page" do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:user))
        expect(page).to have_content "New"
    end
end
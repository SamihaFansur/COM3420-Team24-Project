require_relative "../spec_helper"

#Test Login

describe "the page links" do
    #log in as a student
    it "ECF is accessible from the login page" do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:student))
        expect(page).to have_content "New"
    end
end

describe "the page links" do
    #log in as a staff
    it "ECF is accessible from the login page" do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:staff))
        expect(page).to have_content "New"
    end
end
require_relative "../spec_helper"
require 'rails_helper'

#Test New User

describe "user" do
    #log in as a user
    it "logs is and visits new user page " do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:admin))
        visit"/users/new"
        expect(page).to have_content "New user"
    end
end

describe "user" do
    #log in as a user
    it "creates new user as admin " do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:admin))
        visit"/users/new"
        fill_in "email", with: "sfansur1@sheffield.ac.uk"
        select "Admin", from: "role", visible: false
        click_button "submit"
        expect(page).to have_content "sfansur1@sheffield.ac.uk"
        visit"/users"
        click_link "Show", match: :first
        expect(page).to have_content "User ID:"
        visit"/users"
        click_link "Edit", match: :first
        expect(page).to have_content "Edit role stuff here"
        select "Admin", from: "user[role]", visible: false
        # click_link "Add UserModule", visible: true
        # fill_in "Module code", with: "COM2004"
        click_button "Update User"
        expect(page).to have_content "Listing users"

    end
end
#tests non existing email
describe "user" do
    #log in as a user
    it "creates new user as admin " do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:admin))
        visit"/users/new"
        fill_in "email", with: "sfansur222@sheffield.ac.uk"
        # expect(page).to have_content "Listing users"

    end
end

describe "user" do
    #log in as a user
    it "tests new user link " do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:admin))
        visit"/users"
        click_link "New User"
        expect(page).to have_content "Creating new user"
    end
end

describe "user" do
    it "tests csv user upload " do
        #login
        visit"/users/sign_in"
        login_as(FactoryBot.create(:admin))
        visit"/users"
        click_link "CSV Upload"
        expect(page).to have_content "File"
        #attach csv file
        # attach_file(Rails.root.join("spec/features/csv_test.csv"))
        # attach_file('user[file]', "spec/features/csv_test.csv")
        attach_file('user[file]', Rails.root + "spec/features/csv_test.csv")
        #save users
        click_button "Save User"
        expect(page).to have_content "Listing"
        #test that one of the users in file is added 
        expect(page).to have_content "There are 5 users"
    end
end

        # #test repeated users
        # visit"/users"
        # click_link "CSV Upload"
        # expect(page).to have_content "File"
        # #attach csv file
        # attach_file(Rails.root.join("spec/features/csv_test.csv"))
        # #save users
        # click_button "Save User"
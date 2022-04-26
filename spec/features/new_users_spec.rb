require_relative "../spec_helper"
require 'rails_helper'

#Test New User
describe 'User specs' do
    before do
        allow_any_instance_of(User).to receive(:get_info_from_ldap).and_return(true)
    end
    describe "user" do
        #log in as a student
        it "logs is and visits new user page " do
            visit"/users/sign_in"
            login_as(FactoryBot.create(:student))
            visit"/users/new"
            expect(page).to have_content "New user"
        end
    end

    describe "user" do
        #log in as a module leader
        it "logs is and visits new user page " do
            visit"/users/sign_in"
            login_as(FactoryBot.create(:module_leader))
            visit"/users/new"
            expect(page).to have_content "New user"
        end
    end

    describe "user" do
        #log in as a scrutiny panel member
        it "logs is and visits new user page " do
            visit"/users/sign_in"
            login_as(FactoryBot.create(:scrutiny_panel))
            visit"/users/new"
            expect(page).to have_content "New user"
        end
    end

    describe "user" do
        #log in as a admin
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
            expect(page).to have_content "New user"
        end
    end

    describe "user" do
        it "tests csv user upload ", js: true do 
            #login
            visit"/users/sign_in"
            login_as(FactoryBot.create(:admin))
            visit"/users"
            click_link "CSV Upload"
            expect(page).to have_content "File"
            attach_file('user[file]', Rails.root + "spec/features/csv_test.csv")
            #save users
            click_button "Save User"
            expect(page).to have_content "Listing"
            visit "/users"
            expect(page).to have_content "test"
        end
    end
end

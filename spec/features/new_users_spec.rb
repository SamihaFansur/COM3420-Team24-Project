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
            visit"/ecfs"
            expect(page).to have_content "Listing"
        end
    end

    describe "user" do
        #log in as a module leader
        it "logs is and visits new user page " do
            visit"/users/sign_in"
            login_as(FactoryBot.create(:module_leader))
            visit"/ecfs"
            expect(page).to have_content "Listing"
        end
    end

    describe "user" do
        #log in as a scrutiny panel member
        it "logs is as scrutiny panel " do
            visit"/users/sign_in"
            login_as(FactoryBot.create(:scrutiny_panel))
            visit"/ecfs"
            expect(page).to have_content "Listing"
        end
    end

    describe "user" do
        #log in as a admin
        it "log in as admin " do
            visit"/users/sign_in"
            login_as(FactoryBot.create(:admin))
            visit"/users"
            expect(page).to have_content "Listing users"
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
            expect(page).to have_content "Edit user role here"
            select "Admin", from: "user[role]", visible: false
            click_button "Update User"
            expect(page).to have_content "Listing users"

        end
    end
    #test doesnt work due to needing mock of ldap username
    describe "user" do
        it "creates new user as admin " do
            visit"/users/sign_in"
            login_as(FactoryBot.create(:admin))
            visit"/users/new"
            fill_in "email", with: "sfansur1@sheffield.ac.uk"
            click_button "submit"
            expect(page).to have_content "User was successfully created with role"
        end
    end

    #test doesnt work due to needing mock of ldap username
    describe "user", js: true do
        it "tries to create pre-existing user with email " do
            visit"/users/sign_in"
            login_as(FactoryBot.create(:admin))
            visit"/users/new"
            fill_in "email", with: "sfansur1@sheffield.ac.uk"
            select "Admin", :from => "role"
            click_button "submit"
            visit"/users/new"
            fill_in "email", with: "sfansur1@sheffield.ac.uk"
            select "Admin", :from => "role"
            click_button "submit"
            expect(page).to have_content "This user already exists in the database."
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
            select "Admin", :from => "role"
            click_button "submit"
            expect(page).to have_content "User could not be found with email"

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

    describe "user" do
        it "tests csv user upload failed due to wrong file format", js: true do 
            #login
            visit"/users/sign_in"
            login_as(FactoryBot.create(:admin))
            visit"/users"
            click_link "CSV Upload"
            expect(page).to have_content "File"
            attach_file('user[file]', Rails.root + "spec/features/csv_test_fail.csv")
            #save users
            click_button "Save User"
            expect(page).to have_content "Failed to upload users - CSV file is of the incorrect format."
        end
    end
end

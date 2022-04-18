require_relative "../spec_helper"
require 'rails_helper'

#Test Login

describe "ecf" do
    #log in as a user
    it "logs in and visits ecf page " do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:student))
        visit"/ecfs"
        expect(page).to have_content "Listing"
    end
end

describe "ecf" do
    #log in as a user
    it "fills out and submits ecf " do
        #login in as student 1 and make an ecf
        visit"/users/sign_in"
        login_as(FactoryBot.create(:student))
        visit"/ecfs"
        click_link "Create New ECF"
        fill_in "Details", with: "Example User2"
        fill_in "Unit code", with: "COM2008"
        fill_in "Assessment type", with: "Exam"
        select "DEX - Deadline Extension", from: "Requested action ", visible: false
        click_button "Create Ecf"
        #Check that ecf is listed fro student 1
        expect(page).to have_content "arb20eg"
        click_link "mdo"
        click_link "Sign out"
        expect(page).to have_content "Overview"
        #Logged out and login as student 2
        visit"/users/sign_in"
        login_as(FactoryBot.create(:student2))
        visit"/ecfs"
        click_link "MY ECFS"
        #Check that student 1 user ecf doesnt show up for student 2
        expect(page).not_to have_content "arb20eg"
        #Create ecf for student 2
        visit"/ecfs"
        click_link "Create New ECF"
        fill_in "Details", with: "Example User2"
        fill_in "Unit code", with: "COM2008"
        fill_in "Assessment type", with: "Exam"
        select "DEX - Deadline Extension", from: "Requested action ", visible: false
        click_button "Create Ecf"
        #Check student 2 sees their ecf
        expect(page).to have_content "aca20sf"
    end
end


describe "ecf" do
    #log in as a user
    it "fills out and submits ecf " do
        #login in as student and make an ecf
        visit"/users/sign_in"
        login_as(FactoryBot.create(:student))
        visit"/ecfs"
        click_link "Create New ECF"
        fill_in "Details", with: "Example User2"
        fill_in "Unit code", with: "COM2008"
        fill_in "Assessment type", with: "Exam"
        select "DEX - Deadline Extension", from: "Requested action ", visible: false
        click_button "Create Ecf"
        click_link "Edit", match: :first
        fill_in "Details", with: "updated info"
        #Update ecf info
        click_button "Update Ecf"
        expect(page).to have_content "Listing ECFs"
        #Check that ecf info has been updated
        click_link "Show", match: :first
        expect(page).to have_content "updated info"
    end
end
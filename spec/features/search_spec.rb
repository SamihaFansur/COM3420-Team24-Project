require_relative "../spec_helper"
require 'rails_helper'

#Test search

describe "search" do
    #log in as a user
    it "logs is and visits search page " do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:admin))
        visit"/ecfs"
        expect(page).to have_content "Listing ECFs"
    end
end

#Test search/search
describe "search" do
    #log in as a user
    it "logs is and visits search page " do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:admin))
        visit"/ecfs"
        expect(page).to have_content "Listing ECFs"
    end
end

#search sql injection test (temp)
describe "search" do
    #log in as a user
    it "fills out and submits meetings " do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:student))
        #Create an ECF to test deletion
        visit"/users/sign_in"
        login_as(FactoryBot.create(:student))
        visit"/ecfs"
        click_link "Create New ECF"
        fill_in "Details", with: "Example User2"
        fill_in "Unit code", with: "COM2008"
        fill_in "Assessment type", with: "Exam"
        select "DEX - Deadline Extension", from: "Requested action ", visible: false
        click_button "Create Ecf"
        expect(page).to have_content "arb20eg"
        #Test search functionality
        visit"/ecfs"
        fill_in "q[user_givenname_or_user_sn_cont]", with: "http://www.example.com/articles.php?id=-1; DROP ALL TABLES; --"
        fill_in "q[user_email_cont]", with: "http://www.example.com/articles.php?id=-1; DROP ALL TABLES; --"
        click_button "Search"
        expect(page).to have_content "No result found !"#Tests that either sql injection didnt work or deleted ecfs
        fill_in "q[user_givenname_or_user_sn_cont]", with: ""
        fill_in "q[user_email_cont]", with: ""
        click_button "Search"
        
        expect(page).to have_content "arb20eg"#Confirms whether ecf was deleted or not

    end
end




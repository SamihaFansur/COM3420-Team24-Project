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
    end
end

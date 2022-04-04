require_relative "../spec_helper"
require 'rails_helper'

#Test Login

describe "meetings" do
    #log in as a user
    it "logs is and visits meetings page " do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:student))
        visit"/meetings"
        expect(page).to have_content "Meeting"
    end
end

describe "ecf" do
    #log in as a user
    it "fills out and submits meetings " do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:student))
        visit"/meetings"
        click_link "New Meeting"
        fill_in "Title", with: "1"
        fill_in "Attendees", with: "test"
        click_button "Create Meeting"
        expect(page).to have_content "Attendees: test"
        visit"/meetings"
        expect(page).to have_content "test"
    end
end

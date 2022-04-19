require_relative "../spec_helper"
require 'rails_helper'

#Test ecf notes


describe "notes" do
    #log in as a user
    it "fills out and submits ecf then adds student notes" do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:student2))
        visit"/ecfs"
        expect(page).to have_content "Listing ECFs"
        click_link "Create New ECF"
        fill_in "Details", with: "Example User2"
        fill_in "Unit code", with: "COM2008"
        fill_in "Assessment type", with: "Exam"
        select "DEX - Deadline Extension", from: "Requested action ", visible: false
        click_button "Create Ecf"
        logout(:student)
        login_as(FactoryBot.create(:admin))
        visit"/ecfs"
        click_link "Edit", match: :first
        expect(page).to have_content "Edit ECF"
        expect(page).to have_content "+ Add a Student note"
        # click_button "+ Add a Student note", match: :first
        # expect(page).to have_content "Description"
        # fill_in "ecf[ecf_notes_attributes][1649785385150][description]", with: "test note"
        # click_button "commit"
        # expect(page).to have_content "test note"
        # click_link "Edit", match: :first
    end
end


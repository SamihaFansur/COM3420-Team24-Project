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
        expect(page).to have_content "aca20sf"
        click_link "mdo"
        click_link "Sign out"
        expect(page).to have_content "Overview"
        #Logged out and login as student 2
        visit"/users/sign_in"
        login_as(FactoryBot.create(:student2))
        visit"/ecfs"
        click_link "MY ECFS"
        #Check that student 1 user ecf doesnt show up for student 2
        expect(page).not_to have_content "aca20sf"
        #Create ecf for student 2
        visit"/ecfs"
        click_link "Create New ECF"
        fill_in "Details", with: "Example User2"
        fill_in "Unit code", with: "COM2008"
        fill_in "Assessment type", with: "Exam"
        select "DEX - Deadline Extension", from: "Requested action ", visible: false
        click_button "Create Ecf"
        #Check student 2 sees their ecf
        expect(page).to have_content "aca20sg"
    end
end


describe "ecf" do
    #log in as a user
    it "update ecf " do
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

describe "ecf" do
    #log in as a user
    it "update ecf status " do
        #login in as student and make an ecf
        visit"/users/sign_in"
        login_as(FactoryBot.create(:student2))
        visit"/ecfs"
        click_link "Create New ECF"
        fill_in "Details", with: "Example User2"
        fill_in "Unit code", with: "COM2008"
        fill_in "Assessment type", with: "Exam"
        select "DEX - Deadline Extension", from: "Requested action ", visible: false
        click_button "Create Ecf"
        login_as(FactoryBot.create(:admin))
        visit"/ecfs"
        click_link "Edit", match: :first
        find_field('ecf_status').set('Complete')
        click_button "Update status"
        expect(page).to have_content "Form was successfully updated."
    end
end

describe "ecf" do
    #log in as a user
    it "Add ECF to a meeting " do
        #login in as student and make an ecf
        visit"/users/sign_in"
        login_as(FactoryBot.create(:admin))
        visit"/meetings"
        click_link "New Meeting"
        fill_in "Title", with: "1"
        fill_in "Attendees", with: "test"
        click_button "Create Meeting"
        expect(page).to have_content "Attendees: test"
        visit"/meetings"
        expect(page).to have_content "test"
        login_as(FactoryBot.create(:student2))
        visit"/ecfs"
        click_link "Create New ECF"
        fill_in "Details", with: "Example User2"
        fill_in "Unit code", with: "COM2008"
        fill_in "Assessment type", with: "Exam"
        select "DEX - Deadline Extension", from: "Requested action ", visible: false
        click_button "Create Ecf"
        login_as(FactoryBot.create(:admin))
        visit"/ecfs"
        click_link "Edit", match: :first
        find_field('agenda_meeting_id').set('1')
        click_button "Add to meeting"
        expect(page).to have_content "ECF was successfully added to the meeting."
        find_field('agenda_meeting_id').set('1')
        click_button "Add to meeting"
        expect(page).to have_content "This ECF has already been added to the meeting!"
    end
end

describe "ecf" do
    #log in as a user
    it "Fail to Add ECF to a meeting " do
        #login in as student and make an ecf
        visit"/users/sign_in"
        login_as(FactoryBot.create(:admin))
        visit"/meetings"
        click_link "New Meeting"
        fill_in "Title", with: "1"
        fill_in "Attendees", with: "test"
        click_button "Create Meeting"
        expect(page).to have_content "Attendees: test"
        visit"/meetings"
        expect(page).to have_content "test"
        login_as(FactoryBot.create(:student2))
        visit"/ecfs"
        click_link "Create New ECF"
        fill_in "Details", with: "Example User2"
        fill_in "Unit code", with: "COM2008"
        fill_in "Assessment type", with: "Exam"
        select "DEX - Deadline Extension", from: "Requested action ", visible: false
        click_button "Create Ecf"
        login_as(FactoryBot.create(:admin))
        visit"/ecfs"
        click_link "Edit", match: :first
        find_field('agenda_meeting_id').set('h')
        click_button "Add to meeting"
        expect(page).to have_content "Must enter a meeting ID."
    end
end

describe "ecf" do
    it "uploads evidence to ecf", js: true do 
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
        attach_file 'ecf[upload_medical_evidence][]', 'spec/features/test.pdf'
        click_button "Update evidence"
        expect(page).to have_content "Form was successfully updated."
    end
end


describe "ecf" do
    it "delete ecf over 7 years old", js: true do 
        visit"/users/sign_in"
        login_as(FactoryBot.create(:admin))
        FactoryBot.create(:ecf)
        visit"/ecfs"
        expect(page).to have_content "test"
        click_link "ECFs which need attention as per the GDPR Policy"
        expect(page).to have_content "Todays Date"
        expect(page).to have_content "test"
        click_link "Delete ECF", match: :first
        # find(:xpath, "/html/body/main/div/div[1]/table/tbody/tr[1]/td[8]/a", :text => 'Delete ECF').click 
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "Successfully deleted ECF from system."
    end
end
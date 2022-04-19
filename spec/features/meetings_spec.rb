require_relative "../spec_helper"
require 'rails_helper'





#Test Login

describe "meetings" do
    #log in as a user
    it "logs is and visits meetings page " do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:scrutiny_panel))
        visit"/meetings"
        expect(page).to have_content "Meeting"
    end
end

describe "meeting" do
    #log in as a user
    it "fills out and submits meetings " do
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
    end
end

describe "meeting" do
    #log in as a user
    it "fills out and submits meetings then updates it" do
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
        click_link "Edit"
        fill_in "Attendees", with: "new test"
        click_button "Update Meeting"
        expect(page).to have_content "new test"

    end
end

describe "meeting" do
    #log in as a user
    it "fills out and submits meetings then emails attendees" do
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
        click_link "Edit"
        fill_in "Attendees", with: "new test"
        click_button "Update Meeting"
        expect(page).to have_content "new test"
        visit"/meetings"
        click_link "Email Attendees", match: :first, visible: false
        expect(page).to have_content "Attendees notified"
    end
end

describe "meeting" do
    it "fills out and submits meetings then goes to edit meeting and clicks back" do
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
        click_link "Edit"
        fill_in "Attendees", with: "new test"
        click_button "Update Meeting"
        expect(page).to have_content "new test"
        visit"/meetings"
        click_link "Edit", match: :first, visible: false
        expect(page).to have_content "Editing meeting"
        click_link "Back"
        expect(page).to have_content "Meeting Schedule"
    end
end

describe "meeting" do
    it "fills out and submits meetings then goes to edit meeting and clicks show" do
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
        click_link "Edit"
        fill_in "Attendees", with: "new test"
        click_button "Update Meeting"
        expect(page).to have_content "new test"
        visit"/meetings"
        click_link "Edit", match: :first, visible: false
        expect(page).to have_content "Editing meeting"
        click_link "Show"
        expect(page).to have_content "ECFs on the agenda are listed below"
    end
end

describe "meeting" do
    it "fills out and submits meetings then goes to edit meeting and clicks listing ecfs" do
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
        click_link "Edit"
        fill_in "Attendees", with: "new test"
        click_button "Update Meeting"
        expect(page).to have_content "new test"
        visit"/meetings"
        click_link "Show", match: :first, visible: false
        expect(page).to have_content "ECFs on the agenda are"
        click_link "List ECFs"
        expect(page).to have_content "Listing ECFs"
    end
end

feature "pdf generation" do
 scenario "authenticate user can generate a pdf file through a link" do
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
    click_link "Edit"
    fill_in "Attendees", with: "new test"
    click_button "Update Meeting"
    expect(page).to have_content "new test"
    visit"/meetings"
    click_link "Show", match: :first, visible: false
    expect(page).to have_content "ECFs on the agenda are"
    click_link "Export as PDF" 
    convert_pdf_to_page
    expect(page).to have_content("PDF export date")
 end
end




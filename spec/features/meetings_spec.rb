require 'spec_helper'
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

describe "meeting", js: true do
    it "updates ecf in meeting" do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:admin))
        visit"/meetings"
        click_link "New Meeting"
        fill_in "Title", with: "1"
        fill_in "Attendees", with: "test"
        click_button "Create Meeting"
        expect(page).to have_content "Attendees: test"
        visit "/meetings"
        find(:xpath, "/html/body/main/div/div[1]/div/div/table/tbody/tr[1]/td[6]/a", :text => 'Edit').click 
        expect(page).to have_content "Editing meeting"
        fill_in "Title", with: "new test"
        click_button "Update Meeting"
        expect(page).to have_content "new test"
        visit"/meetings"
        find(:xpath, "/html/body/main/div/div[1]/div/div/table/tbody/tr[1]/td[5]/a", :text => 'Show').click 
        #Confirms test updates
        expect(page).to have_content "new test"

    end
end

describe "meeting" do
    it "adds meeting to agenda", js: true do
        #make intitial ecf for later
        login_as(FactoryBot.create(:student))
        visit"/ecfs"
        click_link "Create New ECF"
        fill_in "Details", with: "Example User2"
        fill_in "Unit code", with: "COM2008"
        fill_in "Assessment type", with: "Exam"
        select "DEX - Deadline Extension", from: "Requested action ", visible: false
        click_button "Create Ecf"
        login_as(FactoryBot.create(:admin))
        visit"/meetings"
        click_link "New Meeting"
        fill_in "Title", with: "title"
        fill_in "meeting[attendees]", with: "test"
        click_button "Create Meeting"
        expect(page).to have_content "Attendees: test"
        visit "/meetings"
        expect(page).to have_content "1"
        expect(Meeting.count).to eq 1
        visit "/meetings/1"
        find(:xpath, '/html/body/main/div/div/div/p[4]/a').click
        expect(page).to have_content "Listing ECFs"
        find(:xpath, "/html/body/main/div/body-1/section/div/div[2]/div/div[3]/div/table/tbody/tr/td[9]/a", :text => 'Edit').click 
        fill_in "agenda[meeting_id]", with: "1"
        click_button "Add to meeting"
        expect(page).to have_content "ECF was successfully added to the meeting"
        visit "/meetings"
        find(:xpath, "/html/body/main/div/div[1]/div/div/table/tbody/tr[1]/td[5]/a", :text => 'Show').click 
        expect(page).to have_content "Pending"
        find(:xpath, "/html/body/main/div/div/div/div[1]/table/tbody/tr/td[11]/a", :text => 'Remove ECF').click 
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "Successfully removed ECF from agenda"
    end
end

describe "meeting", js: true do
    it "destroy meeting test" do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:admin))
        visit"/meetings"
        click_link "New Meeting"
        fill_in "Title", with: "1"
        fill_in "Attendees", with: "test"
        click_button "Create Meeting"
        expect(page).to have_content "Attendees: test"
        visit "/meetings"
        find(:xpath, "/html/body/main/div/div[1]/div/div/table/tbody/tr[1]/td[7]/a", :text => 'Destroy').click 
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "Meeting was successfully destroyed."
        
    end
end




require_relative '../spec_helper'
require 'rails_helper'

# Test Login

describe 'ecf' do
  # log in as a user
  it 'logs in and visits ecf page ' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:student))
    visit '/ecfs'
    expect(page).to have_content 'Listing'
  end
end

describe 'ecf' do
  # log in as a user
  it 'fills out and submits ecf ', js: true do
    # login in as student 1 and make an ecf
    visit '/users/sign_in'
    login_as(FactoryBot.create(:student))
    visit '/ecfs'
    click_link 'Create New ECF'
    fill_in 'Details', with: 'Example User2'
    fill_in 'ecf[affected_units_attributes][0][unit_code]', with: 'COM2008'
    fill_in 'ecf[affected_units_attributes][0][assessment_type]', with: 'Exam'
    fill_in 'ecf[affected_units_attributes][0][date_from]', with: '2022-05-16'
    fill_in 'ecf[affected_units_attributes][0][date_to]', with: '2022-05-16'
    select 'DEX - Deadline Extension', from: 'ecf[affected_units_attributes][0][requested_action]', visible: false
    click_button 'Submit Extenuating Circumstances Form'
    # Check that ecf is listed fro student 1
    expect(page).to have_content 'COM2008'
    find(:xpath, '/html/body/header/div/div/a[2]', text: 'Logout').click
    # page.driver.browser.switch_to.alert.accept
    expect(page).to have_content 'Overview'
    # Logged out and login as student 2
    visit '/users/sign_in'
    login_as(FactoryBot.create(:student2))
    visit '/ecfs'
    click_link 'SHOW ECF'
    # Check that student 1 user ecf doesnt show up for student 2
    expect(page).not_to have_content 'aca20sg'
    # Create ecf for student 2
    visit '/ecfs'
    click_link 'Create New ECF'
    fill_in 'Details', with: 'Example User2'
    fill_in 'ecf[affected_units_attributes][0][unit_code]', with: 'COM2008'
    fill_in 'ecf[affected_units_attributes][0][assessment_type]', with: 'Exam'
    fill_in 'ecf[affected_units_attributes][0][date_from]', with: '2022-05-16'
    fill_in 'ecf[affected_units_attributes][0][date_to]', with: '2022-05-16'
    select 'DEX - Deadline Extension', from: 'ecf[affected_units_attributes][0][requested_action]', visible: false
    click_button 'Submit Extenuating Circumstances Form'
    # Check student 2 sees their ecf
    expect(page).to_not have_content 'aca20sf'
  end
end

describe 'ecf' do
  # log in as a user
  it 'Submit Extenuating Circumstances Form ' do
    # login in as student and make an ecf
    visit '/users/sign_in'
    login_as(FactoryBot.create(:student2))
    visit '/ecfs'
    click_link 'Create New ECF'
    fill_in 'Details', with: 'Example User2'
    fill_in 'ecf[affected_units_attributes][0][unit_code]', with: 'COM2008'
    fill_in 'ecf[affected_units_attributes][0][assessment_type]', with: 'Exam'
    fill_in 'ecf[affected_units_attributes][0][date_from]', with: '2022-05-16'
    fill_in 'ecf[affected_units_attributes][0][date_to]', with: '2022-05-16'
    select 'DEX - Deadline Extension', from: 'ecf[affected_units_attributes][0][requested_action]', visible: false
    click_button 'Submit Extenuating Circumstances Form'
    click_link 'Edit', match: :first
    fill_in 'Details', with: 'updated info'
    # Submit Extenuating Circumstances Form info
    click_button 'Submit Extenuating Circumstances Form'
    expect(page).to have_content 'Listing ECFs'
    # Check that ecf info has been updated
    click_link 'Show', match: :first
    expect(page).to have_content 'updated info'
  end
end

describe 'ecf' do
  # log in as a user
  it 'Submit Extenuating Circumstances Form status ' do
    # login in as student and make an ecf
    visit '/users/sign_in'
    login_as(FactoryBot.create(:student2))
    visit '/ecfs'
    click_link 'Create New ECF'
    fill_in 'Details', with: 'Example User2'
    fill_in 'ecf[affected_units_attributes][0][unit_code]', with: 'COM2008'
    fill_in 'ecf[affected_units_attributes][0][assessment_type]', with: 'Exam'
    fill_in 'ecf[affected_units_attributes][0][date_from]', with: '2022-05-16'
    fill_in 'ecf[affected_units_attributes][0][date_to]', with: '2022-05-16'
    select 'DEX - Deadline Extension', from: 'ecf[affected_units_attributes][0][requested_action]', visible: false
    click_button 'Submit Extenuating Circumstances Form'
    login_as(FactoryBot.create(:admin))
    visit '/ecfs'
    click_link 'Edit', match: :first
    find_field('ecf_status').set('Complete')
    click_button 'Update status'
    expect(page).to have_content 'Form was successfully updated'
  end
end

describe 'ecf' do
  it 'uploads evidence to ecf', js: true do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:student2))
    visit '/ecfs'
    expect(page).to have_content 'Listing ECFs'
    click_link 'Create New ECF'
    fill_in 'Details', with: 'Example User2'
    fill_in 'ecf[affected_units_attributes][0][unit_code]', with: 'COM2008'
    fill_in 'ecf[affected_units_attributes][0][assessment_type]', with: 'Exam'
    fill_in 'ecf[affected_units_attributes][0][date_from]', with: '2022-05-16'
    fill_in 'ecf[affected_units_attributes][0][date_to]', with: '2022-05-16'
    select 'DEX - Deadline Extension', from: 'ecf[affected_units_attributes][0][requested_action]', visible: false
    click_button 'Submit Extenuating Circumstances Form'
    logout(:student)
    login_as(FactoryBot.create(:admin))
    visit '/ecfs'
    click_link 'Edit', match: :first
    expect(page).to have_content 'Edit ECF'
    attach_file 'ecf[upload_medical_evidence][]', 'spec/features/test.pdf'
    click_button 'Update evidence'
    expect(page).to have_content 'Form was successfully updated'
  end
end

describe 'ecf', js: true do
  it 'uploads evidence to ecf then deletes it', js: true do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:student2))
    visit '/ecfs'
    expect(page).to have_content 'Listing ECFs'
    click_link 'Create New ECF'
    fill_in 'Details', with: 'Example User2'
    fill_in 'ecf[affected_units_attributes][0][unit_code]', with: 'COM2008'
    fill_in 'ecf[affected_units_attributes][0][assessment_type]', with: 'Exam'
    fill_in 'ecf[affected_units_attributes][0][date_from]', with: '2022-05-16'
    fill_in 'ecf[affected_units_attributes][0][date_to]', with: '2022-05-16'
    select 'DEX - Deadline Extension', from: 'ecf[affected_units_attributes][0][requested_action]', visible: false
    click_button 'Submit Extenuating Circumstances Form'
    logout(:student2)
    login_as(FactoryBot.create(:admin))
    visit '/ecfs'
    click_link 'Edit', match: :first
    expect(page).to have_content 'Edit ECF'
    attach_file 'ecf[upload_medical_evidence][]', 'spec/features/test.pdf'
    click_button 'Update evidence'
    expect(page).to have_content 'Form was successfully updated'
    click_link 'Delete attachment'
    expect(page).to have_content 'Successfully deleted attachment'
  end
end

describe 'ecf' do
  it 'delete ecf over 7 years old', js: true do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:admin))
    FactoryBot.create(:ecf)
    visit '/ecfs'
    expect(page).to have_content 'test'
    click_link 'ECFs which need to be removed from the system as per the GDPR Policy'
    expect(page).to have_content 'Todays Date'
    expect(page).to have_content 'test'
    click_link 'Delete ECF', match: :first
    # find(:xpath, "/html/body/main/div/div[1]/table/tbody/tr[1]/td[8]/a", :text => 'Delete ECF').click
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content 'Successfully deleted ECF from system.'
  end
end

describe 'ecf', js: true do
  it 'add decision to agenda', js: true do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:admin))
    FactoryBot.create(:ecf)
    visit '/meetings'
    click_link 'New Meeting'
    fill_in 'meeting[title]', with: 'test'
    fill_in 'meeting[attendees]', with: 'test'
    click_button 'Create Meeting'
    expect(page).to have_content 'Meeting attendees should have received email invitation.'
    click_link 'List ECFs', match: :first
    click_link 'Add to meeting #', match: :first
    visit '/outcomes'
    click_link 'New Outcome'
    fill_in 'outcome[name]', with: 'Approved'
    fill_in 'outcome[short_name]', with: 'Approved'
    fill_in 'outcome[description]', with: 'Y'
    click_button 'Create Outcome'
    visit '/ecfs'
    click_link 'Edit', match: :first
    select 'Approved', from: 'decision[outcome_id]'
    find('#decision_button').click
    expect(page).to have_content 'Decisions for test'
  end
end

describe 'ecf', js: true do
  it 'fail to add decision to agenda', js: true do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:admin))
    FactoryBot.create(:ecf)
    visit '/meetings'
    click_link 'New Meeting'
    fill_in 'meeting[title]', with: 'test'
    fill_in 'meeting[attendees]', with: 'test'
    click_button 'Create Meeting'
    expect(page).to have_content 'Meeting attendees should have received email invitation.'
    click_link 'List ECFs', match: :first
    click_link 'Add to meeting #', match: :first
    visit '/outcomes'
    click_link 'New Outcome'
    fill_in 'outcome[name]', with: 'Approved'
    fill_in 'outcome[short_name]', with: 'Approved'
    fill_in 'outcome[description]', with: 'Y'
    click_button 'Create Outcome'
    visit '/ecfs'
    click_link 'Edit', match: :first
    find('#decision_button').click
    expect(page).not_to have_content 'Decisions for test'
  end
end

describe 'ecf', js: true do
  it 'status complete', js: true do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:admin))
    FactoryBot.create(:ecf)
    visit '/ecfs'
    click_link 'Edit', match: :first
    select 'Complete', from: 'ecf[status]', visible: false
    click_button 'Update status'
    expect(page).to have_content 'Form was successfully updated'
  end
end



describe 'ecf', js: true do
  it 'uploads evidence to ecf then deletes it', js: true do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:student2))
    visit '/ecfs'
    expect(page).to have_content 'Listing ECFs'
    click_link 'Create New ECF'
    fill_in 'Details', with: 'Example User2'
    fill_in 'ecf[affected_units_attributes][0][unit_code]', with: 'COM2008'
    fill_in 'ecf[affected_units_attributes][0][assessment_type]', with: 'Exam'
    fill_in 'ecf[affected_units_attributes][0][date_from]', with: '2022-05-16'
    fill_in 'ecf[affected_units_attributes][0][date_to]', with: '2022-05-16'
    select 'DEX - Deadline Extension', from: 'ecf[affected_units_attributes][0][requested_action]', visible: false
    click_button 'Submit Extenuating Circumstances Form'
    visit '/ecfs'
    click_link 'Edit', match: :first
    fill_in 'Details', with: 'test'
    sleep(0.5)
    click_button 'Submit Extenuating Circumstances Form'
    expect(page).to have_content 'Form was successfully updated'
  end
end


describe 'outcome', js: true do
  it 'update outcome', js: true do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:admin))
    FactoryBot.create(:ecf)
    visit '/meetings'
    click_link 'New Meeting'
    fill_in 'meeting[title]', with: 'test'
    fill_in 'meeting[attendees]', with: 'test'
    click_button 'Create Meeting'
    expect(page).to have_content 'Meeting attendees should have received email invitation.'
    click_link 'List ECFs', match: :first
    click_link 'Add to meeting #', match: :first
    visit '/outcomes'
    click_link 'New Outcome'
    fill_in 'outcome[name]', with: 'Approved'
    fill_in 'outcome[short_name]', with: 'Approved'
    fill_in 'outcome[description]', with: 'Y'
    click_button 'Create Outcome'
    visit '/outcomes'
    click_link 'Edit', match: :first
    fill_in 'outcome[name]', with: 'Rejected'
    click_button 'Update Outcome'
    expect(page).to have_content 'Outcome was successfully updated.'
  end
end

# describe 'ecf', js: true do
#   it 'module leader view ecfs', js: true do
#     visit '/users/sign_in'
#     login_as(FactoryBot.create(:student))
#     visit '/ecfs'
#     click_link 'Create New ECF'
#     fill_in 'Details', with: 'Example User2'
#     fill_in 'ecf[affected_units_attributes][0][unit_code]', with: 'com3420'
#     fill_in 'ecf[affected_units_attributes][0][assessment_type]', with: 'Exam'
#     fill_in 'ecf[affected_units_attributes][0][date_from]', with: '2022-05-16'
#     fill_in 'ecf[affected_units_attributes][0][date_to]', with: '2022-05-16'
#     select 'DEX - Deadline Extension', from: 'ecf[affected_units_attributes][0][requested_action]', visible: false
#     click_button 'Submit Extenuating Circumstances Form'
#     # Check that ecf is listed fro student 1
#     expect(page).to have_content 'com3420'
#     find(:xpath, '/html/body/header/div/div/a[2]', text: 'Logout').click
#     visit '/users/sign_in'
#     login_as(FactoryBot.create(:module_leader))
#     # find(:xpath, '/html/body/header/div/div/a[2]', text: 'Logout').click
#     visit '/users/sign_in'
#     login_as(FactoryBot.create(:admin))
#     visit '/users'
#     find(:xpath, "//tr[contains(.,'module leader')]/td/a", :text => 'Edit').click
#     expect(page).to have_content 'ac1arx'
#     find(:xpath, "/html/body/main/div/div[2]/div/form/a").click
#     fill_in 'Module code', with: 'com3420'
#     click_button 'Update User'
#     expect(page).to have_content 'User was successfully updated.'
#     find(:xpath, '/html/body/header/div/div/a[2]', text: 'Logout').click
#     visit '/users/sign_in'
#     login_as(FactoryBot.create(:module_leader))
#     visit '/ecfs'
#     expect(page).to have_content 'There are 1 ecfs'
#   end
# end
require_relative '../spec_helper'
require 'rails_helper'

# Test ecf notes

# Note for Student
describe 'notes' do
  it 'fills out and submits ecf then adds student notes', js: true do
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
    expect(page).to have_content '+ Add a Student note'
    click_button '+ Add a Student note', match: :first
    fill_in 'Description *', with: 'test'
    click_button 'Submit note'
    expect(page).to have_content 'Form was successfully updated.'
  end
end

describe 'notes' do
  it 'fills out and submits ecf then adds student notes', js: true do
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
    expect(page).to have_content '+ Add a Student note'
    click_button '+ Add a Student note', match: :first
    find(:xpath, '/html/body/main/div/div/div/form[3]/div/div/div[2]/input').set('test')
    click_button 'Submit note'
    expect(page).to have_content 'Form was successfully updated.'
    click_link 'Delete note'
    expect(page).to have_content 'Note was successfully deleted.'
  end
end

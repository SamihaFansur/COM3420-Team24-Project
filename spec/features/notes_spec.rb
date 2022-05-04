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
    fill_in 'Unit code', with: 'COM2008'
    fill_in 'Assessment type', with: 'Exam'
    select 'DEX - Deadline Extension', from: 'Requested action ', visible: false
    click_button 'Create Ecf'
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
    fill_in 'Unit code', with: 'COM2008'
    fill_in 'Assessment type', with: 'Exam'
    select 'DEX - Deadline Extension', from: 'Requested action ', visible: false
    click_button 'Create Ecf'
    logout(:student)
    login_as(FactoryBot.create(:admin))
    visit '/ecfs'
    click_link 'Edit', match: :first
    expect(page).to have_content 'Edit ECF'
    expect(page).to have_content '+ Add a Student note'
    click_button '+ Add a Student note', match: :first
    fill_in 'Description *', with: 'test'
    click_button 'Submit note'
    expect(page).to have_content 'Form was successfully updated. '
    click_link 'Delete note'
    expect(page).to have_content 'Note was successfully deleted.'
  end
end

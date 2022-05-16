require 'spec_helper'
require 'rails_helper'

# Test Login

describe 'outcome' do
  it 'logs in and visits outcomes page ' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:admin))
    visit '/outcomes'
    expect(page).to have_content 'Listing outcomes'
  end
end

describe 'outcome' do
  it 'fills out and submits outcome' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:admin))
    visit '/outcomes'
    click_link 'New Outcome'
    fill_in 'Name', with: 'test'
    fill_in 'Short name', with: 'test'
    fill_in 'Description', with: 'test'
    click_button 'Create Outcome'
    expect(page).to have_content 'Outcome was successfully created.'
    visit '/outcomes'
    expect(page).to have_content 'test'
  end
end

describe 'outcome' do
  it 'create outcome and view on show' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:admin))
    visit '/outcomes'
    click_link 'New Outcome'
    fill_in 'Name', with: 'test'
    fill_in 'Short name', with: 'test'
    fill_in 'Description', with: 'test'
    click_button 'Create Outcome'
    expect(page).to have_content 'Outcome was successfully created.'
    visit '/outcomes'
    expect(page).to have_content 'test'
    find(:xpath, '/html/body/main/div/section/div/div/div/table/tbody/tr/td[4]/a', text: 'Show').click
    expect(page).to have_content 'test'
  end
end

describe 'outcome' do
  it 'edit outcome' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:admin))
    visit '/outcomes'
    click_link 'New Outcome'
    fill_in 'Name', with: 'test'
    fill_in 'Short name', with: 'test'
    fill_in 'Description', with: 'test'
    click_button 'Create Outcome'
    expect(page).to have_content 'Outcome was successfully created.'
    visit '/outcomes'
    expect(page).to have_content 'test'
    find(:xpath, '/html/body/main/div/section/div/div/div/table/tbody/tr/td[5]/a', text: 'Edit').click
    fill_in 'Name', with: 'new test'
    fill_in 'Short name', with: 'new test'
    fill_in 'Description', with: 'new test'
    click_button 'Update Outcome'
    expect(page).to have_content 'new test'
  end
end

describe 'outcome', js: true do
  it 'destroys outcome' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:admin))
    visit '/outcomes'
    click_link 'New Outcome'
    fill_in 'Name', with: 'test'
    fill_in 'Short name', with: 'test'
    fill_in 'Description', with: 'test'
    click_button 'Create Outcome'
    expect(page).to have_content 'Outcome was successfully created.'
    visit '/outcomes'
    expect(page).to have_content 'test'
    find(:xpath, '/html/body/main/div/section/div/div/div/table/tbody/tr/td[6]/a', text: 'Destroy').click
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content 'Outcome was successfully destroyed.'
  end
end

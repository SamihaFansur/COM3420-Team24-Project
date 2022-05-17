require_relative '../spec_helper'
require 'rails_helper'

# Test search

describe 'search' do
  # log in as a user
  it 'logs is and visits search page ' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:admin))
    visit '/ecfs'
    expect(page).to have_content 'Listing ECFs'
  end
end

# Test search/search
describe 'search' do
  # log in as a user
  it 'logs is and visits search page ' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:admin))
    visit '/ecfs'
    expect(page).to have_content 'Listing ECFs'
  end
end

# search sql injection test (temp)
describe 'search' do
  # log in as a user
  it 'fills out and submits meetings ' do
    # Create an ECF to test deletion
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
    expect(page).to have_content 'COM2008'
    login_as(FactoryBot.create(:admin))
    visit '/ecfs'
    expect(page).to have_content 'aca20sf' # first ecf check
    # #Test search functionality
    find_field('q[status_eq]').set('Pending')
    find_field('q[user_givenname_or_user_sn_cont]').set('')
    click_button 'Search'
    expect(page).to have_content 'aca20sf' # second ecf check
  end
end

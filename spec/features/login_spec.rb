require_relative '../spec_helper'
require 'rails_helper'
# Test Login

describe 'login' do
  # log in as a student
  it 'as a student ' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:student))
    visit '/ecfs'
    expect(page).to have_content 'Listing'
  end
end

describe 'login' do
  # log in as a module leader
  it 'as a staff ' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:module_leader))
    visit '/ecfs'
    expect(page).to have_content 'Listing'
  end
end

describe 'login' do
  # log in as a scrutiny panel member
  it 'as a staff ' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:scrutiny_panel))
    visit '/ecfs'
    expect(page).to have_content 'Listing'
  end
end

describe 'login' do
  # log in as a admin/chair
  it 'as a staff ' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:admin))
    visit '/ecfs'
    expect(page).to have_content 'Listing'
  end
end

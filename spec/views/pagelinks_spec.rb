require_relative '../spec_helper'
require 'rails_helper'

# Logged out Link Tests

describe 'the page links' do
  # through navigation go to sign up page
  it 'login is accessible from the home page' do
    visit '/'
    click_link 'LOGIN'
    expect(page).to have_content 'Login'
  end
end

describe 'the page links' do
  # through navigation go to sign up page
  it 'login is accessible from the ECF page' do
    visit '/users/sign_in'
    click_link 'LOGIN'
    expect(page).to have_content 'Login'
  end
end

describe 'the page links' do
  # through navigation go to home page
  it 'home is accessible from the ECF page' do
    visit '/users/sign_in'
    click_link 'INFORMATION'
    expect(page).to have_content 'Form'
  end
end

describe 'the page links' do
  # through navigation go to home page
  it 'home is accessible from the login page' do
    visit '/'
    click_link 'INFORMATION'
    expect(page).to have_content 'Form'
  end
end

# Logged in as Student

describe 'the page links' do
  it 'home is accessible after loggin in' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:student2))
    click_link 'INFORMATION'
    expect(page).to have_content 'Extenuating Circumstances Form'
  end
end

describe 'the page links' do
  it 'new ecf is accessible after logging in' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:student2))
    visit '/'
    click_link 'SHOW ECF'
    click_link 'Create New ECF'
    expect(page).to have_content 'Start of circumstances'
  end
end

describe 'the page links' do
  it 'new ecf is accessible after logging in' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:student2))
    visit '/ecfs'
    click_link 'SHOW ECF'
    expect(page).to have_content 'Listing ECFs'
  end
end

describe 'the page links' do
  it 'show ecf accessible after making new ecf' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:student2))
    visit '/'
    click_link 'SHOW ECF'
    click_link 'Create New ECF'
    fill_in 'Details', with: 'Example User2'
    fill_in 'ecf[affected_units_attributes][0][unit_code]', with: 'COM2008'
    fill_in 'ecf[affected_units_attributes][0][assessment_type]', with: 'Exam'
    fill_in 'ecf[affected_units_attributes][0][date_from]', with: '2022-05-16'
    fill_in 'ecf[affected_units_attributes][0][date_to]', with: '2022-05-16'
    select 'DEX - Deadline Extension', from: 'ecf[affected_units_attributes][0][requested_action]', visible: false
    click_button 'Submit Extenuating Circumstances Form'
    click_link 'Edit'
    expect(page).to have_content 'DEX'
  end
end

describe 'the page links' do
  it 'show ecf accessible after making new ecf' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:student2))
    visit '/'
    click_link 'SHOW ECF'
    click_link 'Create New ECF'
    fill_in 'Details', with: 'Example User2'
    fill_in 'ecf[affected_units_attributes][0][unit_code]', with: 'COM2008'
    fill_in 'ecf[affected_units_attributes][0][assessment_type]', with: 'Exam'
    fill_in 'ecf[affected_units_attributes][0][date_from]', with: '2022-05-16'
    fill_in 'ecf[affected_units_attributes][0][date_to]', with: '2022-05-16'
    select 'DEX - Deadline Extension', from: 'ecf[affected_units_attributes][0][requested_action]', visible: false
    click_button 'Submit Extenuating Circumstances Form'
    click_link 'Show'
    expect(page).to have_content 'ECF Details'
  end
end

# Logged in as Module Leader

describe 'the page links' do
  it 'login as module leader' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:module_leader))
    visit '/ecfs'
    expect(page).to have_content 'Listing ECFs'
  end
end

describe 'the page links' do
  it 'login as module leader + visit home page ' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:module_leader))
    visit '/ecfs'
    click_link 'INFORMATION'
    expect(page).to have_content 'Overview'
  end
end

describe 'the page links' do
  it 'login as module leader + visit SHOW ECF page ' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:module_leader))
    visit '/ecfs'
    click_link 'SHOW ECF'
    expect(page).to have_content 'Listing ECFs'
  end
end

# Logged in as a Scrutiny Panel Member

describe 'the page links' do
  it 'login as Scrutiny Panel' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:scrutiny_panel))
    visit '/ecfs'
    expect(page).to have_content 'Listing ECFs'
  end
end

describe 'the page links' do
  it 'login as Scrutiny Panel + visit home page ' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:scrutiny_panel))
    visit '/ecfs'
    click_link 'INFORMATION'
    expect(page).to have_content 'Overview'
  end
end

describe 'the page links' do
  it 'login as Scrutiny Panel + visit SHOW ECF page ' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:scrutiny_panel))
    visit '/ecfs'
    click_link 'SHOW ECF'
    expect(page).to have_content 'Listing ECFs'
  end
end

describe 'the page links' do
  it 'login as Scrutiny Panel + visit show meetings page ' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:scrutiny_panel))
    visit '/ecfs'
    click_link 'SHOW MEETINGS'
    expect(page).to have_content 'Meeting Schedule'
  end
end

describe 'the page links' do
  it 'login as Scrutiny Panel + visit new meeting page ' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:admin))
    visit '/ecfs'
    click_link 'SHOW MEETINGS'
    expect(page).to have_content 'Meeting Schedule'
    click_link 'New Meeting'
    expect(page).to have_content 'New meeting'
  end
end

describe 'the page links' do
  it 'login as Scrutiny Panel + test new meeting back button' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:admin))
    visit '/ecfs'
    click_link 'SHOW MEETINGS'
    expect(page).to have_content 'Meeting Schedule'
    click_link 'New Meeting'
    expect(page).to have_content 'New meeting'
    click_link 'Back'
    expect(page).to have_content 'Meeting Schedule'
  end
end

# Logged in as an Admin

describe 'the page links' do
  it 'login as admin' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:admin))
    visit '/ecfs'
    expect(page).to have_content 'Listing ECFs'
  end
end

describe 'the page links' do
  it 'login as admin + visit home page ' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:admin))
    visit '/ecfs'
    click_link 'INFORMATION'
    expect(page).to have_content 'Overview'
  end
end

describe 'the page links' do
  it 'login as admin + visit SHOW ECF page ' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:admin))
    visit '/ecfs'
    click_link 'SHOW ECF'
    expect(page).to have_content 'Listing ECFs'
  end
end

describe 'the page links' do
  it 'login as admin + visit SHOW meetings page ' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:admin))
    visit '/ecfs'
    click_link 'SHOW MEETINGS'
    expect(page).to have_content 'Meeting Schedule'
  end
end

describe 'the page links' do
  it 'login as admin + visit SHOW users page ' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:admin))
    visit '/ecfs'
    click_link 'USERS'
    expect(page).to have_content 'Listing users'
  end
end

describe 'the page links' do
  it 'login as admin + visit new users page ' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:admin))
    visit '/ecfs'
    click_link 'USERS'
    expect(page).to have_content 'Listing users'
    click_link 'New User'
  end
end

describe 'the page links' do
  it 'login as admin + visit csv upload page ' do
    visit '/users/sign_in'
    login_as(FactoryBot.create(:admin))
    visit '/ecfs'
    click_link 'USERS'
    expect(page).to have_content 'Listing users'
    click_link 'CSV Upload'
  end
end

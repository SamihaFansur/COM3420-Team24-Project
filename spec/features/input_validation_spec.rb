require 'rails_helper'

# check whether the system rejects an SQL input
describe 'SQL injection attempt' do
    specify 'SQL injection should be rejected' do
        visit 'users/sign_in'
        fill_in 'Username', with: "' or 1=1 -- "
        fill_in 'Password', with: 'test'
        click_on 'Login'
        # should reject user
        expect(page).to have_content 'Invalid Username or password.'
    end
end
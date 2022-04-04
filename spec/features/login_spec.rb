require_relative "../spec_helper"
require 'rails_helper'
#Test Login



describe "login" do
    #log in as a user
    it "as a student " do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:student))
        visit"/ecfs"
        expect(page).to have_content "Listing"
    end
end

describe "login" do
    #log in as a user
    it "as a staff " do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:staff))
        visit"/ecfs"
        expect(page).to have_content "Listing"
    end
end

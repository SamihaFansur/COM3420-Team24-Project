require_relative "../spec_helper"
require 'rails_helper'

#Test search

describe "search" do
    #log in as a user
    it "logs is and visits search page " do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:staff))
        visit"/search"
        expect(page).to have_content "Listing ECFs"
    end
end

#Test search/search
describe "search" do
    #log in as a user
    it "logs is and visits search page " do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:staff))
        visit"/search"
        expect(page).to have_content "Listing ECFs"
    end
end

#search sql injection test (temp)
describe "search" do
    #log in as a user
    it "fills out and submits meetings " do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:student))
        visit"/search"
        fill_in "q[status_cont]", with: "http://www.example.com/articles.php?id=-1; DROP ALL TABLES; --"
        fill_in "q[user_uid_cont]", with: "http://www.example.com/articles.php?id=-1; DROP ALL TABLES; --"
        click_button "Search"
        expect(page).to have_content "There are no current ECFs !"

    end
end

#search/search sql injection test (temp)
describe "search" do
    #log in as a user
    it "fills out and submits meetings " do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:student))
        visit"/search/search"
        fill_in "q[status_cont]", with: "http://www.example.com/articles.php?id=-1; DROP ALL TABLES; --"
        fill_in "q[user_uid_cont]", with: "http://www.example.com/articles.php?id=-1; DROP ALL TABLES; --"
        click_button "Search"
        expect(page).to have_content "There are no current ECFs !"

    end
end



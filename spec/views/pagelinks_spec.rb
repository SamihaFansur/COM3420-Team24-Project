require_relative "../spec_helper"
require 'rails_helper'

#Logged out Link Tests

describe "the page links" do
    #through navigation go to sign up page
    it "login is accessible from the home page" do
        visit"/"
        click_link "LOGIN"
        expect(page).to have_content "Login"
    end
end

describe "the page links" do
    #through navigation go to sign up page
    it "login is accessible from the ECF page" do
        visit"/users/sign_in"
        click_link "LOGIN"
        expect(page).to have_content "Login"
    end
end


describe "the page links" do
    #through navigation go to home page
    it "home is accessible from the ECF page" do
        visit"/users/sign_in"
        click_link "HOME"
        expect(page).to have_content "Form"
    end
end

describe "the page links" do
    #through navigation go to home page
    it "home is accessible from the login page" do
        visit"/"
        click_link "HOME"
        expect(page).to have_content "Form"
    end
end


# Logged in tests

describe "the page links" do
    #once logged in, through navigation goes to ecfs page
    it "ecfs is accessible after loggin in" do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:student))
        click_link "LOGIN"
        expect(page).to have_content "Listing ecfs"
    end
end

describe "the page links" do
    #once logged in, through navigation goes to home page
    it "home is accessible after loggin in" do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:student))
        click_link "HOME"
        expect(page).to have_content "Extenuating Circumstances Form"
    end
end

describe "the page links" do
    #once logged in, through navigation goes to new ecf page
    it "new ecf is accessible after logging in" do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:student))
        click_link "LOGIN"
        click_link "Create New ECF"
        expect(page).to have_content "Start of circumstances"
    end
end

describe "the page links" do
    #once logged in, through navigation goes view exisiting ecf
    it "show ecf accessible after making new ecf" do
        visit"/users/sign_in"
        login_as(FactoryBot.create(:student))
        click_link "LOGIN"
        click_link "Create New ECF"
        fill_in "Details", with: "Details about ecf"
        fill_in "Unit code", with: "COMtest"
        fill_in "Assessment type", with: "Test"
        select "NP - No penalty for late submission", from: "Requested action ", visible: false
        click_button "Create Ecf"
        click_link "Show"
        expect(page).to have_content "Student Details"
        visit "/ecfs"
        click_link "Edit"
        expect(page).to have_content "Editing form"
    end
end

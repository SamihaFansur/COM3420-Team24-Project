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

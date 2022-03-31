require_relative "../spec_helper"

#Logged out Link Tests

describe "the page links" do
    #through navigation go to sign up page
    it "sign in is accessible from the home page" do
        visit"/"
        click_link "ECF"
        expect(page).to have_content "Log In"
    end
end

describe "the page links" do
    #through navigation go to sign up page
    it "sign in is accessible from the Login page" do
        visit"/login/index"
        click_link "ECF"
        expect(page).to have_content "Log in"
    end
end

describe "the page links" do
    #through navigation go to sign up page
    it "sign in is accessible from the Login page" do
        visit"/users/sign-in"
        click_link "ECF"
        expect(page).to have_content "Log in"
    end
end


describe "the page links" do
    #through navigation go to sign up page
    it "login is accessible from the home page" do
        visit"/"
        click_link "Login"
        expect(page).to have_content "Login"
    end
end

describe "the page links" do
    #through navigation go to sign up page
    it "login is accessible from the ECF page" do
        visit"/users/sign_in"
        click_link "Login"
        expect(page).to have_content "Login"
    end
end

describe "the page links" do
    #through navigation go to sign up page
    it "login is accessible from the login page" do
        visit"/login/index"
        click_link "Login"
        expect(page).to have_content "Login"
    end
end

describe "the page links" do
    #through navigation go to sign up page
    it "home is accessible from the ECF page" do
        visit"/users/sign_in"
        click_link "HOME"
        expect(page).to have_content "Form"
    end
end

describe "the page links" do
    #through navigation go to sign up page
    it "home is accessible from the login page" do
        visit"/login/index"
        click_link "HOME"
        expect(page).to have_content "Form"
    end
end

describe "the page links" do
    #through navigation go to sign up page
    it "home is accessible from the login page" do
        visit"/"
        click_link "HOME"
        expect(page).to have_content "Form"
    end
end



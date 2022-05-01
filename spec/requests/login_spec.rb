require 'rails_helper'

RSpec.describe "Logins", type: :request do
  describe "GET /index" do
    it "returns http success" do
      visit "/users/sign_in"
      expect(page).to have_content "ECF Login"
      expect(page).to have_current_path(new_user_session_path)
    end
  end

end

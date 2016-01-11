require 'rails_helper'

RSpec.feature "UserCanSignups", type: :feature do
  context "user is not already signed in" do
    context "and the user is on the login page" do
      before(:each) do
        visit "/login"
      end
      it "can click sign up and be brought to signup page" do
        click_link_or_button "Sign Up"

        expect(current_path).to.eq("/signup")
      end
    end
  end
end

require 'rails_helper'

RSpec.feature "UserCanLogouts", type: :feature do
  context "user is already signed in" do
    before(:each) do
      visit "/signup"
      fill_in('Email*', :with => 'valid@emailaddress.com')
      fill_in('Password*', :with => 'validpassword')
      fill_in('Confirm Password*', :with => 'validpassword')

      click_link_or_button "Create Account"
    end
    context "and the user is on the links index" do
      before(:each) do
        visit "/"
      end
      it "can click sign up and be brought to signup page" do
        expect(current_path).to eq("/")

        click_link_or_button("Sign Out")
        expect(current_path).to eq("/login")
      end
    end
  end
end

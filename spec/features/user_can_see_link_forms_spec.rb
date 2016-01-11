require 'rails_helper'

RSpec.feature "UserCanSeeLinkForms", type: :feature do
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
      it "can see a form to make a new idea" do
        expect(current_path).to eq("/")
        expect(page).to have_css("input[name='link[title]']")
        expect(page).to have_css("input[name='link[url]']")
        expect(page).to have_css("input[type='submit']")
      end
    end
  end
end

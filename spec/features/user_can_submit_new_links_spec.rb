require 'rails_helper'

RSpec.feature "UserCanSubmitNewLinks", type: :feature do
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
      it "should be able to submit a valid link" do
        expect(current_path).to eq("/")
        fill_in("Title", with: "validtitle")
        fill_in("Link", with: "http://validlink.com")
        click_link_or_button "Submit Link"
        expect(page).to have_content("validtitle")
        expect(page).to have_content("http://validlink.com")

      end
    end
  end
end

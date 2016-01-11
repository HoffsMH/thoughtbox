require 'rails_helper'

RSpec.feature "ChangeReadStatuses", type: :feature do
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
      context "and there is a linkg" do
        before(:each) do
          fill_in("Title", with: "validtitle")
          fill_in("Link", with: "http://validlink.com")
          click_link_or_button "Submit Link"
        end
        it "should be able to change the read status", js: true do
          within(:css, ".idea") do
            find('.mark', :text => 'mark as read').click
            expect(page).not_to have_content("mark as read")
            expect(page).to have_content("mark as unread")
          end
        end
      end
    end
  end
end

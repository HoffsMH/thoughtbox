require 'rails_helper'

RSpec.feature "FilterBySearches", type: :feature do
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
      context "and there are Multiple Links" do
        before(:each) do
          @user = User.find_by(email: "valid@emailaddress.com");
          @link1 = Link.create(title: "zzzzz", url: "http://zzzz.com", user_id: @user.id);
          @link2 = Link.create(title: "aaaaa", url: "http://aaaaaa.com", user_id: @user.id);
          visit "/"
        end
        it "shouldn't filter when we have nothing", js: true do
          expect(page).to have_content("zzzzz")
          expect(page).to have_content("aaaaa")
        end
        it "should filter one link", js: true do
          fill_in "search", with: "a"
          expect(page).not_to have_content("zzzzz")
          expect(page).to have_content("aaaaa")
        end
        it "should filter another link", js: true do
          fill_in "search", with: "z"
          expect(page).to have_content("zzzzz")
          expect(page).not_to have_content("aaaa")
        end
        it "should filter both links", js: true do
          fill_in "search", with: "s"
          expect(page).not_to have_content("zzzzz")
          expect(page).not_to have_content("aaaa")

        end
      end
    end
  end
end

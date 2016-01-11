require 'rails_helper'

RSpec.feature "UserCanSignups", type: :feature do
  context "user is not already signed in" do
    context "and the user is on the login page" do
      before(:each) do
        visit "/login"
      end
      it "can click sign up and be brought to signup page" do
        click_link_or_button "Sign Up"

        expect(current_path).to eq("/signup")
      end
    end
    context "and the user is on the signup page" do
      before(:each) do
        visit "/signup"
      end
      context "and the user puts in valid information" do
        before(:each) do
          fill_in('Email*', :with => 'valid@emailaddress.com')
          fill_in('Password*', :with => 'validpassword')
          fill_in('Confirm Password*', :with => 'validpassword')
        end
        it "signs up the user" do
          click_link_or_button "Create Account"
          user = User.find_by(email: "valid@emailaddress.com")
          expect(user).not_to eq(nil)
        end

        it "redirects to the links index" do
          click_link_or_button "Create Account"
          expect(current_path).to eq("/")
        end
      end

      context "and the user puts in invalid email" do
        before(:each) do
          fill_in('Email*', :with => 'invalidemail')
          fill_in('Password*', :with => 'validpassword')
          fill_in('Confirm Password*', :with => 'validpassword')
        end
        it "does not sign up the user" do
          click_link_or_button "Create Account"
          user = User.find_by(email: "invalidemail")
          expect(user).to eq(nil)
        end
      end

      context "and the users passwords don't match" do
        before(:each) do
          fill_in('Email*', :with => 'valid@email.com')

          fill_in('Password*',         :with => 'these passwords')
          fill_in('Confirm Password*', :with => 'do not match')
        end
        it "does not sign up the user" do
          click_link_or_button "Create Account"
          user = User.find_by(email: "valid@email.com")
          expect(user).to eq(nil)
        end
      end

      context "and the users email has alread been used" do
        before(:each) do
          @user       = User.create(email: "already@inuse.com",
                                    password: "password",
                                    password_confirmation: "password")
          @initial_user_count = User.count

          fill_in('Email*', :with => 'already@inuse.com')

          fill_in('Password*',         :with => 'something')
          fill_in('Confirm Password*', :with => 'something')
        end
        it "does not sign up the user" do
          click_link_or_button "Create Account"
          current_user_count = User.count
          expect(current_user_count).to eq(@initial_user_count)
        end
      end
    end
  end
end

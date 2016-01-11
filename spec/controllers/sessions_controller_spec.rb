require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET sessions#destroy' do
    context 'logged in' do
      before(:each) do
        @user = User.create(email: "valid@email.com",
                            password: "validpassword",
                            password_confirmation: "validpassword")
        session[:user_id] = @user.id
      end
      it 'redirects to session#new' do
        get :destroy
        expect(session[:user_id]).to eq(nil)
        expect(response).to redirect_to("/login")
      end
    end
  end

end

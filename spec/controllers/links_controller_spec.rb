require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  describe 'GET links#index' do
    context 'not logged in' do
      it 'redirects to session#new' do
        get :index

        expect(response).to redirect_to("/login")
      end
    end
  end


end

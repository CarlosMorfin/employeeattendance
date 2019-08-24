require 'rails_helper'

describe Admin::RootController do

  describe 'GET #show', method: :get, action: :show do

    context 'when the authenticated user has the administrator role' do

      before(:each) do
        sign_in FactoryBot.create(:user, :administrator)
      end

      it 'redirects to index employees page' do
        do_request

        expect(response).to redirect_to admin_employees_path
      end

    end

  end

end

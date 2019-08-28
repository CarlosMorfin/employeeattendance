require 'rails_helper'

describe Admin::Employees::UsersController do

  before(:each) do
    sign_in @user
  end

  describe 'GET #show', method: :get, action: :show do

    before(:each) do
      @employee = FactoryBot.create(:employee)
    end

    let(:default_params) do
      { employee_id: @employee.id }
    end

    it 'the requested employee is recovering' do
      do_request

      expect(assigns(:employee)).to eq(@employee)
    end

  end

end

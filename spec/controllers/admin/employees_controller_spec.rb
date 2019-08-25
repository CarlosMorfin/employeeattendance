require 'rails_helper'

describe Admin::EmployeesController do

  before(:each) do
    sign_in @user
  end

  describe 'GET #index', method: :get, action: :index do

    before(:each) do
      @employee_1 = FactoryBot.create(:employee, name: 'Juan')
      @employee_2 = FactoryBot.create(:employee, name: 'Araceli')
      @employee_3 = FactoryBot.create(:employee, name: 'Lupita')
    end

    it 'assigns to the @employees instance all the employees ordered by ' \
       'ascending name' do
      do_request

      expect(assigns(:employees)).to eq [@employee_2, @employee_1, @employee_3]
    end

    it 'responds succesfully' do
      do_request

      expect(response).to have_http_status(:success)
    end

    it 'render index template' do
      do_request

      expect(response).to render_template :index
    end

  end

  describe 'GET #show', method: :get, action: :show do

    context 'when the employee exists' do

      before(:each) do
        @employee = FactoryBot.create(:employee)
      end

      let(:default_params) do
        { id: @employee.id }
      end

      it 'assigns the requested employee to @employee' do
        do_request

        expect(assigns(:employee)).to eq @employee
      end

      it 'renders the :show template' do
        do_request

        expect(response).to render_template :show
      end

    end

    context 'when the employee does not exist' do

      let(:default_params) do
        { id: 9999 }
      end

      it 'raises an ActiveRecord::RecordNotFound  error' do
        expect { do_request }.to raise_error ActiveRecord::RecordNotFound
      end

    end

  end

end

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

  describe 'POST #create', method: :post, action: :create do

    let(:default_params) do
      {
        employee: {
          name:       'Juan',
          last_names: 'Gonzalez Diaz',
          gender:     'M',
          email:      'juangonzalez@gmail.com',
          phone:      '3315892889',
          code:       'AAA12'
        }
      }
    end

    context 'with valid attributes' do

      it 'creates a new employee' do
        expect { do_request }.to change(Employee, :count).by(1)
      end

      it 'assigns the code to the created employee' do
        do_request

        employee = Employee.last

        expect(employee.code).to eq default_params[:employee][:code]
      end

      it 'assigns the name to the created employee' do
        do_request

        employee = Employee.last

        expect(employee.name).to eq default_params[:employee][:name]
      end

      it 'assigns the last_names to the created employee' do
        do_request

        employee = Employee.last

        expect(employee.last_names).to eq default_params[:employee][:last_names]
      end

      it 'assigns the gender to the created employee' do
        do_request

        employee = Employee.last

        expect(employee.gender).to eq default_params[:employee][:gender]
      end

      it 'assigns the phone to the created employee' do
        do_request

        employee = Employee.last

        expect(employee.phone).to eq default_params[:employee][:phone]
      end

      it 'assigns the email to the created employee' do
        do_request

        employee = Employee.last

        expect(employee.email).to eq default_params[:employee][:email]
      end

      it 'assigns a flash notice message' do
        do_request

        expect(flash[:notice]).not_to be_nil
      end

      it 'redirects to show page' do
        do_request

        employee = Employee.last

        expect(response).to redirect_to action: :show, id: employee.id
      end

    end

    context 'without valid attributes' do

      let(:default_params) do
        {
          employee: {
            name:       nil,
            last_names: 'Gonzalez Diaz',
            gender:     'M',
            email:      'juangonzalez@gmail.com',
            phone:      '3315892889',
            code:       'AAA12'
          }
        }
      end

      it 'does not create a new employee' do
        expect { do_request }.not_to change(Employee, :count)
      end

      it 'assigns a flash alert message' do
        do_request

        expect(flash[:alert]).not_to be_nil
      end

      it 'render the :new template' do
        do_request

        expect(response).to render_template :new
      end

    end

  end

  describe 'GET #new', method: :get, action: :new do

    before(:each) do
      FactoryBot.create(:employee, code: 'ABC0012')
    end

    it 'assigns a new employee instance to @employee' do
      do_request

      expect(assigns(:employee)).to be_a_instance_of(Employee)
    end

    it 'assigns a new recommended code with the consecutive number of the ' \
       'last employee code generated to the new instance of code' do
      do_request

      expect(assigns(:employee).code).to eq 'ABC0013'
    end

    it 'renders the :new template' do
      do_request

      expect(response).to render_template :new
    end

  end

  describe 'GET #edit', method: :get, action: :edit do

    before(:each) do
      @employee = FactoryBot.create(:employee)
    end

    context 'when the employee exists' do

      let(:default_params) do
        { id: @employee.id }
      end

      it 'assigns the requested employee to @employee' do
        do_request

        expect(assigns(:employee)).to eq @employee
      end

      it 'renders the :edit template' do
        do_request

        expect(response).to render_template :edit
      end

    end

    context 'when the employee does not exists' do

      let(:default_params) do
        { id: 9999 }
      end

      it 'raises an ActiveRecord::RecordNotFound  error' do
        expect { do_request }.to raise_error ActiveRecord::RecordNotFound
      end

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

  describe 'PATCH #update', method: :patch, action: :update do

    before(:each) do
      @employee = FactoryBot.create(:employee)
    end

    context 'with valid attributes' do

      let(:default_params) do
        {
          id: @employee.id,
          employee: {
            name:       'Juan',
            last_names: 'Gonzalez Diaz',
            gender:     'M',
            email:      'juangonzalez@gmail.com',
            phone:      '3315892889',
            code:       'AAA12'
          }
        }
      end

      it 'assigns the requested employeee to @employee' do
        do_request

        expect(assigns(:employee)).to eq @employee
      end

      it 'updates the code of the employee' do
        do_request

        @employee.reload

        expect(@employee.code).to eq default_params[:employee][:code]
      end

      it 'updates the name of the employee' do
        do_request

        @employee.reload

        expect(@employee.name).to eq default_params[:employee][:name]
      end

      it 'updates the last_names of the employee' do
        do_request

        @employee.reload

        expect(@employee.last_names).to eq default_params[:employee][:last_names]
      end

      it 'updates the gender of the employee' do
        do_request

        @employee.reload

        expect(@employee.gender).to eq default_params[:employee][:gender]
      end

      it 'updates the phone of the employee' do
        do_request

        @employee.reload

        expect(@employee.phone).to eq default_params[:employee][:phone]
      end

      it 'updates the email of the employee' do
        do_request

        @employee.reload

        expect(@employee.email).to eq default_params[:employee][:email]
      end

      it 'redirects to index page' do
        do_request

        expect(response).to redirect_to admin_employees_path
      end

    end

    context 'without valid attributes' do

      let(:default_params) do
        {
          id: @employee.id,
          employee: {
            name:       'Juan',
            last_names: 'Gonzalez Diaz',
            gender:     'F',
            email:      'juangonzalez@gmail.com',
            phone:      '3315892889',
            code:       nil
          }
        }
      end

      it 'assigns the requested employeee to @employee' do
        do_request

        expect(assigns(:employee)).to eq @employee
      end

      it 'does not update the code of the employee' do
        do_request

        expect { @employee.reload }.not_to change(@employee, :code)
      end

      it 'does not update the name of the employee' do
        do_request

        expect { @employee.reload }.not_to change(@employee, :name)
      end

      it 'does not update the last_names of the employee' do
        do_request

        expect { @employee.reload }.not_to change(@employee, :last_names)
      end

      it 'does not update the gender of the employee' do
        do_request

        expect { @employee.reload }.not_to change(@employee, :gender)
      end

      it 'does not update the phone of the employee' do
        do_request

        expect { @employee.reload }.not_to change(@employee, :phone)
      end

      it 'updates the email of the employee' do
        do_request

        expect { @employee.reload }.not_to change(@employee, :email)
      end

      it 'redirects to index page' do
        do_request

        expect(response).to render_template :edit
      end

    end

  end

  describe 'DELETE #destroy', method: :delete, action: :destroy do

    before(:each) do
      @employee = FactoryBot.create(:employee)
    end

    context 'when the eemployee exists' do

      let(:default_params) do
        { id: @employee.id }
      end

      it 'deletes the employee' do
        expect { do_request }.to change(Employee, :count).by(-1)
      end

      it 'redirects to :index page' do
        do_request

        expect(response).to redirect_to action: :index
      end

    end

    context 'when the employee does not exists' do

      let(:default_params) do
        { id: 9999 }
      end

      it 'raises an ActiveRecord::RecordNotFound  error' do
        expect { do_request }.to raise_error ActiveRecord::RecordNotFound
      end

    end

  end

end

require 'rails_helper'

describe Admin::AttendancesController do

  before(:each) do
    sign_in @user
  end

  describe 'GET #index', method: :get, action: :index do

    before(:each) do
      #employees without current attendance
      @employee_1 = FactoryBot.create(:employee, name: 'Pedro')
      @employee_2 = FactoryBot.create(:employee, name: 'Araceli')

      #employee_attendances without check_out
      @attendance_1 = FactoryBot.create(
        :attendance,
        employee: FactoryBot.create(:employee),
        check_in: Time.zone.now - 3.hours
      )
      @attendance_2 = FactoryBot.create(
        :attendance,
        employee:  FactoryBot.create(:employee),
        check_in: Time.zone.now - 2.hours
      )

      #employee_attendances with check_out
      FactoryBot.create(
        :attendance,
        employee: @employee_1,
        check_out: Time.zone.now - 1.hours
      )
      FactoryBot.create(
        :attendance,
        employee: @employee_1,
        check_out: Time.zone.now)
    end

    it 'assigns all employees who do not have current attendance to the ' \
       'employees_without_attendance variable' do
      do_request

      expect(assigns(:employees_without_attendance)).to eq [@employee_2, @employee_1]
    end

    it 'assigns to the variable @current_attendances all employees attendances ' \
       'that do not have check_out ordered by check_in ascending' do
      do_request

      expect(assigns(:current_attendances)).to eq [@attendance_2, @attendance_1]
    end

    it 'assigns to the @employee_attendance variable a new instance of '\
       'Attendance' do
      do_request

      expect(assigns(:employee_attendance)).to be_a_instance_of(Attendance)
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

    before(:each) do
      @employee = FactoryBot.create(:employee)
    end

    let(:default_params) do
      {
        attendance: {
          employee_id: @employee.id,
        }
      }
    end

    context 'with valid attributes' do

      it 'creates a new attendance' do
        expect { do_request }.to change(Attendance, :count).by(1)
      end

      it 'assign the employee_id' do
        do_request

        employee_attendance = Attendance.last

        expect(employee_attendance.employee_id).to eq default_params[:attendance][:employee_id]
      end

      it 'assign the check_in to the attendance' do
        do_request

        employee_attendance = Attendance.last

        expect(employee_attendance.check_in).not_to eq be_nil
      end


      it 'redirects to index page' do
        do_request

        expect(response).to redirect_to admin_attendances_path
      end

    end

    context 'without valid attributes' do

      before(:each) do
        default_params[:attendance][:employee_id] = nil
      end

      it 'does not create a new attendance' do
        expect { do_request }.not_to change(Attendance, :count)
      end

      it 'assigns a flash alert message' do
        do_request

        expect(flash[:alert]).not_to be_nil
      end

      it 'renders the :index template' do
        do_request

        expect(response).to redirect_to admin_attendances_path
      end

    end

  end

  describe 'PATCH #update', method: :patch, action: :update do

    before(:each) do
      @employee_attendance = FactoryBot.create(:attendance)
    end

    context 'with valid attributes' do

      let(:default_params) do
        { id: @employee_attendance.id }
      end

      it 'assigns the checkout to the attendance' do
        do_request

        @employee_attendance.reload

        expect(@employee_attendance.check_out).not_to be_nil
      end

      it 'redirects to index page' do
        do_request

        expect(response).to redirect_to admin_attendances_path
      end

    end

    context 'when attendance does not exists' do

      let(:default_params) do
        { id: 999 }
      end

      it 'raises an ActiveRecord::RecordNotFound error' do
        expect { do_request }.to raise_error ActiveRecord::RecordNotFound
      end

    end

  end

end

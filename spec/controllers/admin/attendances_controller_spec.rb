require 'rails_helper'

describe Admin::AttendancesController do

  before(:each) do
    sign_in @user
  end

  describe 'GET #index', method: :get, action: :index do

    before(:each) do
      #employee_attendances without checkout
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

      #employee_attendances with checkout
      FactoryBot.create(
        :attendance,
        employee: FactoryBot.create(:employee),
        check_out: Time.zone.now - 1.hours
      )
      FactoryBot.create(:attendance, check_out: Time.zone.now)
    end

    it 'assigns to the variable @current_attendances all employees attendances ' \
       'that do not have check_out ordered by check_in ascending' do
      do_request

      expect(assigns(:current_attendances)).to eq [@attendance_2, @attendance_1]
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

end

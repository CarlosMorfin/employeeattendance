module Admin::Employees

  class AttendancesController < AdminController

    def index
      @employee = Employee.find(params[:employee_id])

      @attendances = Attendance.where(employee_id: params[:employee_id])
    end

    private

    def active_nav_tab
      :attendances
    end

    def active_main_navbar
      :employees
    end

  end

end

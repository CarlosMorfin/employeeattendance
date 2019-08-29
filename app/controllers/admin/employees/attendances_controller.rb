module Admin::Employees

  class AttendancesController < AdminController

    def index
      @employee = Employee
        .accessible_by(current_ability)
        .find_by(id: params[:employee_id])


      @attendances = Attendance
        .accessible_by(current_ability)
        .where(employee_id: params[:employee_id])
        .order(check_in: :desc)

      authorize! :read, @employee
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

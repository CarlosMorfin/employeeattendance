module Admin

  class AttendancesController < AdminController

    def index
      @current_attendances = Attendance.current_attendances
      @employees_without_attendance = get_employees_without_attendance
      @employee_attendance = Attendance.new
    end

    def create
      employee_attendance = Attendance.new(attendance_params)
      employee_attendance.check_in = Time.zone.now

      if employee_attendance.save
        flash[:notice] = t('.success')
      else
        flash[:alert] = t('.error')
      end

      redirect_to admin_attendances_path
    end

    def update
      employee_attendance = Attendance.find(params[:id])
      employee_attendance.check_out = Time.zone.now

      if employee_attendance.save
        flash[:notice] = t('.success')
      else
        flass[:alert] = t('.error')
      end

      redirect_to admin_attendances_path
    end

    private

    def active_main_navbar
      :attendances
    end

    def attendance_params
      params.require(:attendance)
        .permit(
          :employee_id,
        )
    end

    def get_employees_without_attendance
      Employee
        .joins(<<-SQL)
          LEFT JOIN (
            SELECT employee_id
            FROM attendance
            WHERE check_out IS NULL
          ) current_attendances
          ON employee.id = current_attendances.employee_id
        SQL
        .where('current_attendances.employee_id IS NULL')
        .order(name: :asc)
    end

  end

end

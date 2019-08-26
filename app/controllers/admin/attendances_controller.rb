module Admin

  class AttendancesController < AdminController

    def index
      @current_attendances = Attendance.current_attendances
    end

    private

    def active_main_navbar
      :attendances
    end

  end

end

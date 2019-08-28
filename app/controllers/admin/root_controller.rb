module Admin

  class RootController < AdminController

    def show
      case
      when can?(:index, :admin_employees)
        redirect_to admin_employees_path
      when can?(:read, :admin_employees_attendances)
        redirect_to admin_employee_attendances_path(current_user.employee)
      end
    end

  end

end

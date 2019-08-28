module Admin::Employees

  class UsersController < AdminController

    def show
      @employee = Employee.find(params[:employee_id])
    end

    private

    def active_nav_tab
      :user
    end

    def active_main_navbar
      :employees
    end

  end

end

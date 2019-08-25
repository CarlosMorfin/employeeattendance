module Admin

  class EmployeesController < AdminController

    def index
      @employees = Employee.order(:name)
    end

  end

end

module Admin

  class EmployeesController < AdminController

    before_action :find_employee,
      only: [:edit, :show, :update, :destroy]

    def index
      @employees = Employee.order(:name)
    end

    def create
      @employee = Employee.new(employee_params)

      if @employee.save
        flash[:notice] = t('.success')
        redirect_to admin_employee_path(@employee)
      else
        flash[:alert] = t('.error')
        render :new
      end
    end

    def new
      @employee = Employee.new(code: recommended_code)
    end

    def edit ; end

    def show ; end

    def update
      if @employee.update(employee_params)
        flash[:notice] = t('.success')
        redirect_to admin_employees_path
      else
        flash[:alert] = t('.error')
        render :edit
      end
    end

    def destroy
      if @employee.destroy
        flash[:notice] = t('.success')
        redirect_to action: :index
      else
        flash.now[:alert] = t('.error')
        render :edit
      end
    end

    private

    def employee_params
      params.require(:employee)
        .permit(
          :code,
          :name,
          :last_names,
          :gender,
          :email,
          :phone
        )
    end

    def find_employee
      @employee = Employee.find(params[:id])
    end

    def recommended_code
      code = Employee.last&.code || return

      code_number = code[/\d+/]

      if code_number.to_i > 0
        new_code_number = "%0#{code_number.length}d" % (code_number.to_i + 1)
        code = code.gsub(code_number, new_code_number)
      end
    end

  end

end

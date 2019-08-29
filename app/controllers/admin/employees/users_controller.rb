module Admin::Employees

  class UsersController < AdminController

    before_action :find_employee,
      only: [:show, :edit, :update]

    before_action :find_user,
      only: [:edit, :update]

    before_action :get_roles,
      only: [:edit, :update]

    def show
    end

    def edit
    end

    def update
      if @employee.update(update_params)
        flash[:notice] = t('.success')
        redirect_to action: :show
      else
        flash.now['alert'] = t('.error')
        render :edit
      end
    end

    private

    def active_nav_tab
      :user
    end

    def active_main_navbar
      :employees
    end

    def update_params
      params.require(:employee)
        .permit(
          user_attributes: [
            :employee_id,
            :email,
            :password,
            :password_confirmation,
            role_ids: []
          ]
      )
    end

    def find_employee
      @employee = Employee.accessible_by(current_ability).find(params[:employee_id])
    end

    def find_user
      @user = @employee.user || @employee.build_user
    end

    def get_roles
      @roles = Role.order(:code)
    end

  end

end

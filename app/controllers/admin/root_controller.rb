module Admin

  class RootController < AdminController

    def show
      case
      when can?(:index, :admin_employees)
        redirect_to admin_employees_path
      end
    end

  end

end

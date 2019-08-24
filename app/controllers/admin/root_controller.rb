module Admin

  class RootController < AdminController

    def show
      redirect_to admin_employees_path
    end

  end

end

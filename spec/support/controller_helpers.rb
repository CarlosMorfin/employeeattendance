module ControllerHelpers

  def example
    self.class
  end

  def description
    example.metadata[:parent_example_group][:description_args].first
  end

  def method
    example.metadata[:method]
  end

  def action
    example.metadata[:action]
  end

  def do_request(extra_parameters = {})
    message = <<-STR
      the method or action has not been provided for #{description}
    STR
    raise message unless method && action
    parameters = {}
    parameters.merge!(default_params) if respond_to?(:default_params)
    parameters.merge!(extra_parameters)
    send(method, action, params: parameters)
  end

  def create_defined_roles
    load ActiveRecord::Tasks::DatabaseTasks.db_dir + '/seeds/roles.rb'

    @defined_roles = Role.all
  end

  def destroy_defined_roles
    @defined_roles.destroy_all
  end

  def create_user
    FactoryBot.create(:user, roles: @defined_roles)
  end

  def destroy_user(user)
    user.destroy
  end

end

RSpec.configure do |config|

  # Helper methods for controllers
  config.include ControllerHelpers, type: :controller

  config.before(:all, type: :controller) do
    create_defined_roles

    @user = create_user
  end

  config.after(:all, type: :controller) do
    destroy_user(@user)

    destroy_defined_roles
  end

end

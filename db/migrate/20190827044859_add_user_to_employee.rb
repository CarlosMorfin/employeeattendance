class AddUserToEmployee < ActiveRecord::Migration[5.2]

  def up
    add_reference :user, :employee, foreign_key: true
  end

  def down
    remove_reference :user, :employee
  end

end

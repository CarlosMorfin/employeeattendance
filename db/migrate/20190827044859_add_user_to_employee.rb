class AddUserToEmployee < ActiveRecord::Migration[5.2]

  def up
    add_reference :user, :employee, foreign_key: { on_delete: :cascade }

  end

  def down
    remove_reference :user, :employee
  end

end

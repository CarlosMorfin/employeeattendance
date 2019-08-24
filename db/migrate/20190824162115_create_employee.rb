class CreateEmployee < ActiveRecord::Migration[5.2]
  def change
    create_table :employee do |t|
      t.string     :code,              limit: 32,  null: false
      t.string     :name,              limit: 64,  null: false
      t.string     :last_names,        limit: 64,  null: false
      t.string     :gender,            limit: 1,   null: false
      t.string     :email,             limit: 128, null: false
      t.string     :phone,             limit: 32

      t.timestamps
    end

    add_index :employee, :code, unique: true
    add_index :employee, :name
  end
end

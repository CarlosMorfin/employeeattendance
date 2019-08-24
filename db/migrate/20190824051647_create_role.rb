class CreateRole < ActiveRecord::Migration[5.2]
  def change
    create_table :role do |t|
      t.string :code, limit: 32, null: false

      t.timestamps
    end

    add_index :role, :code, unique: true
  end
end

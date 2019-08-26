class CreateAttendance < ActiveRecord::Migration[5.2]
  def change
    create_table :attendance do |t|
      t.datetime   :check_in, null:false
      t.datetime   :check_out
      t.belongs_to :employee, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end

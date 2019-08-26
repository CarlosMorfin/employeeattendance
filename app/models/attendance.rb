class Attendance < ApplicationRecord

  belongs_to :employee

  validates :employee_id,
    presence: true

  validates :check_in,
    presence: true

end

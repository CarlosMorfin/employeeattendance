class Attendance < ApplicationRecord

  scope :current_attendances, -> { where(check_out: nil).order(check_in: :desc) }

  belongs_to :employee

  delegate :code, :full_name, to: :employee, prefix: :employee

  validates :employee_id,
    presence: true

  validates :check_in,
    presence: true

end

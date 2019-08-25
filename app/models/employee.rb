class Employee < ApplicationRecord

  GENDER_OPTIONS = %w(M F)

  validates :code,
    presence:   true,
    uniqueness: true,
    length:     { maximum: 32 }

  validates :name,
    presence: true,
    length:   { maximum: 64 }

  validates :last_names,
    presence: true,
    length:   { maximum: 64 }

  validates :gender,
    inclusion: { in: GENDER_OPTIONS }

  validates :email,
    presence:   true,
    uniqueness: true,
    length:     { maximum: 128 }

  validates :phone,
    presence: true,
    length:   { maximum: 32 }

  def full_name
    "#{self.name} #{self.last_names}"
  end

end

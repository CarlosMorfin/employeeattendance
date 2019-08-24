class Role < ApplicationRecord

  has_and_belongs_to_many :users

  validates :code,
    presence:   true,
    uniqueness: true,
    length:     { maximum: 32 }

end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :employee

  has_and_belongs_to_many :roles

  validates :email,
    presence:   true,
    uniqueness: true,
    format:     { with: Devise.email_regexp }

  validates :password,
    confirmation: true,
    length:       { in: 6..16 },
    if:           proc { |user| user.password.present? }

  validates :password,
    presence: true,
    on:       :create

  validates :password_confirmation,
    presence: true,
    if:       proc { |user| user.password.present? }

  validates :roles,
    presence: true
end

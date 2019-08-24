FactoryBot.define do
  factory :user do
    sequence(:email)      { |n| "user_#{n}@example.com" }
    password              { 'mypassword' }
    password_confirmation { 'mypassword' }
  end
end

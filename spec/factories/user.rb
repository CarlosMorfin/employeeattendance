FactoryBot.define do
  factory :user do
    sequence(:email)      { |n| "user_#{n}@example.com" }
    roles                 { [FactoryBot.build(:role)] }
    password              { 'mypassword' }
    password_confirmation { 'mypassword' }

    trait :administrator do
      roles { [FactoryBot.create(:role, :administrator)] }
    end
  end
end

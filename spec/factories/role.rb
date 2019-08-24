FactoryBot.define do
  factory :role do
    sequence(:code) { |n| "code_#{n}" }
  end
end

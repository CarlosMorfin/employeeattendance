FactoryBot.define do
  factory :role do
    sequence(:code) { |n| "code_#{n}" }

    trait :administrator do
      code { :administrator }
    end

    initialize_with do
      Role.find_or_initialize_by(code: code)
    end
  end
end

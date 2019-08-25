FactoryBot.define do
  factory :employee do
    sequence(:code)  { |n| "code_#{n}" }
    sequence(:email) { |n| "faa#{n}@example.com"}
    name             { 'First_name' }
    last_names       { 'Last_name' }
    phone            { '442 345 1244' }
    gender           { 'M' }
  end
end

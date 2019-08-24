FactoryBot.define do
  factory :employee do
    sequence(:code) { |n| "code_#{n}" }
    name            { 'First_name' }
    last_names      { 'Last_name' }
    email           { 'faa@example.com' }
    phone           { '442 345 1244' }
    gender          { 'M' }
  end
end

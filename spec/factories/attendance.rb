FactoryBot.define do
  factory :attendance do
    association :employee

    check_in { Time.zone.now }
  end
end

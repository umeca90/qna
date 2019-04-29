FactoryBot.define do
  factory :comment do
    body { "text text" }

    trait :invalid do
      body { nil }
    end
  end
end
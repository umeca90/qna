FactoryBot.define do
  factory :answer do
    body { 'MyText' }

    trait :invalid do
      body { nil }
    end
    
    trait :edit_body do
      body { 'New body' }
    end
  end
end

FactoryBot.define do
  factory :link do
    name { "MyString" }
    url { "https://gist.github.com/umeca90/e78cf4488daf5cd37d098b790879d405" }

    trait :invalid_link do
      name { "MyString" }
      url { nil }
    end
  end
end

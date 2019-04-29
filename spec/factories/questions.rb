FactoryBot.define do
  factory :question do
    title { 'MyString' }
    body { 'MyText' }
    association :author, factory: :user

    trait :invalid do
      title { nil }
    end

    trait :with_files do
      files { fixture_file_upload("#{Rails.root}/spec/rails_helper.rb") }
    end

    trait :with_links do
      after(:create) { |question| create(:link, linkable: question) }
    end

    trait :with_comments do
      after(:create) { |question| create(:comment, commentable: question, author: question.author) }
    end
  end
end

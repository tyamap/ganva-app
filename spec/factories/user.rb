FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "member#{n}@example.com"}
    name {'山田タロー'}
    sequence(:uid) { |n| "member#{n}"}
    password {'password'}
    with_empty_activities

    trait :with_empty_activities do
      after(:build) do |user|
        user.activities = []
      end
    end

    trait :with_commit_activities do
      after(:build) do |user|
        user.activities << FactoryBot.build(:activity)
        user.activities << FactoryBot.build(:activity)
      end
    end

    trait :with_result_activities do
      after(:build) do |user|
        user.activities << FactoryBot.build(:activity, :with_recorded)
        user.activities << FactoryBot.build(:activity, :with_recorded)
      end
    end
  end
end

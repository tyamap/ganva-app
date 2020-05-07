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
        user.activities << FactoryBot.build(:activity, date: Date.new(2020, 3, 2))
      end
    end

    trait :with_result_activities do
      after(:build) do |user|
        user.activities << FactoryBot.build(:activity, status: Settings.activity.status_recorded)
        user.activities << FactoryBot.build(:activity, date: Date.new(2020, 3, 2), status: Settings.activity.status_recorded)
      end
    end
  end

  factory :activity do
    date {Date.new(2020, 3, 1)}
    start_time {date.to_time + (60*60*12)}
    end_time {date.to_time + (60*60*14)}
    association :gym, factory: :gym
    level {1}
    description {"テスト"}
    status {Settings.activity.status_ready}
  end

  factory :gym do
    name {"GANVAジム中目黒"}
    postal_code {"153-0051"}
    prefecture {"東京都"}
    city {"目黒区"}
    address1 {"上中目黒3-4-1"}
    address2 {"中目黒駅5F"}
    introduction {"【未経験歓迎】中目黒駅にあるかもしれないアットホームなボルダリングジムです。"}
    latitude {35.6441631}
    longitude {139.6988444}
  end
end

FactoryBot.define do
  factory :activity do
    association :user, factory: :user
    association :gym, factory: :gym
    level {1}
    description {"テスト"}
    with_ready

    trait :with_ready do
      date {Time.zone.tomorrow}
      start_time {'12:30'}
      end_time {'13:30'}
      status {Settings.activity.status.ready}
    end
    trait :with_aborted do
      date {Time.zone.tomorrow}
      start_time {'12:30'}
      end_time {'13:30'}
      status {Settings.activity.status.aborted}
    end
    trait :with_done do
      date {Time.zone.yesterday}
      start_time {'12:30'}
      end_time {'13:30'}
      status {Settings.activity.status.done}
    end
    trait :with_recorded do
      date {Time.zone.yesterday}
      start_time {'12:30'}
      end_time {'13:30'}
      status {Settings.activity.status.recorded}
    end
  end
end

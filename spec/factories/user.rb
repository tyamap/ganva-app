FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "member#{n}@example.com"}
    name {'山田タロー'}
    sequence(:uid) { |n| "member#{n}"}
    password {'password'}
  end
end
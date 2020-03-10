FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "member#{n}@example.com"}
    name {'山田タロー'}
    uid {'yamada_taro'}
    password {'pw'}
  end
end
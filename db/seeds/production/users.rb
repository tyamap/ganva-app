User.create!(
  email: 'test@example.com', 
  password: 'password', 
  name: 'テスト', 
  uid: 'test_admin', 
  experience: '5', 
  frequency: '1',
  level: '3', 
  status: 'stable', 
  introduction: 'テスト',
  gym: Gym.first,
) 

5.times do |n|
  User.create!(
    email: "test#{n+1}@example.com",
    password: 'password',
    name: "test_#{n}",
    uid: "id_#{n}",
    experience: n % 10,
    frequency: n % 5,
    level: n % 6,
    status: 'stable',
    introduction: 'テスト用です。'
  )
end

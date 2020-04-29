User.create!(
  email: 'test@example.com', 
  password: 'password', 
  name: 'テスト', 
  uid: 'test_admin', 
  experience: '5', 
  frequency: '1',
  level: '3', 
  status: 'stable', 
  introduction: 'どーも。',
  gym_id: 1,
) 

names_1 = %w{
  佐藤:sato
  鈴木:suzuki
  高橋:takahashi
  田中:tanaka
}

names_2 = %w{
  ジロウ:jiro
  サブロウ:saburo
  マツコ:matsuko
  タケコ:takeko
  ウメコ:umeko
}

20.times do |n|
  un1 = names_1[n % 4].split(":")
  un2 = names_2[n % 5].split(":")

  User.create!(
    email: "#{un1[1]}_#{un2[1]}@example.com",
    password: "password",
    name: un1[0] + '_' + un2[0],
    uid: un1[1][0..2] + un2[1],
    experience: n % 10, 
    frequency: n % 5,
    level: n % 6, 
    status: 'stable', 
    introduction: 'テスト用です。'
  )
end

users = User.all
user  = users.first
10.times do |n|
  user.commit_activities.create(
    name: "#{n+1}回目の挑戦！",
    description: "今日は〇〇ジムでレベル#{n%2}に挑戦！#{(n+1)*2}回ゴール達成するまで頑張ります！" 
  )
  user.result_activities.create(
    name: "#{(n+1)*2}回ゴールしました！",
    description: "今日は〇〇ジムでレベル#{n%2}に挑戦しました！#{(n+1)*2}回ゴール達成しました！" 
  )
end
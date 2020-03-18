users = User.all
user  = users.first
9.times do |n|
  @activity = user.activities.create(
    title: "#{n+1}回目の挑戦！",
    date: Date.today,
    description: "今日はジム#{n%3+1}でレベル#{n%2}に挑戦！#{(n+1)*2}回ゴール達成するまで頑張ります！" 
  )

  case n%3
  when 0 then
    @activity.create_commit_record(
      start_time: Time.now - (60*60*2),
      end_time: Time.now,
      where: "ジム#{n%3+1}",
      level: "#{n%2}",
    )
    @activity.create_result_record(
      start_time: Time.now - (60*60*2),
      end_time: Time.now,
      where: "ジム#{n%3+1}",
      level: "#{n%2}",
    )
  when 1 then
    @activity.create_commit_record(
      start_time: Time.now - (60*60*2),
      end_time: Time.now,
      where: "ジム#{n%3+1}",
      level: "#{n%2}",
    )
  when 2 then
    @activity.create_result_record(
      start_time: Time.now - (60*60*2),
      end_time: Time.now,
      where: "ジム#{n%3+1}",
      level: "#{n%2}",
    )
  end
end
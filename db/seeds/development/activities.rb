users = User.all
user  = users.first
date  = Date.new(2020, 3, 1)

9.times do |n|
  @date =  date.next_day(n)
  @activity = user.activities.create(
    title: "#{n+1}回目の挑戦！",
    date: @date,
    description: "今日はジム#{n%3+1}でレベル#{n%2}に挑戦！#{(n+1)*2}回ゴール達成するまで頑張ります！" 
  )

  case n%3
  when 0 then
    @activity.create_commit_record(
      start_time: @date.to_time + (60*60*12),
      end_time: @date.to_time + (60*60*14),
      where: "ジム#{n%3+1}",
      level: "#{n%2}",
    )
    @activity.create_result_record(
      start_time: @date.to_time + (60*60*12),
      end_time: @date.to_time + (60*60*14),
      where: "ジム#{n%3+1}",
      level: "#{n%2}",
    )
  when 1 then
    @activity.create_commit_record(
      start_time: @date.to_time + (60*60*12),
      end_time: @date.to_time + (60*60*14),
      where: "ジム#{n%3+1}",
      level: "#{n%2}",
    )
  when 2 then
    @activity.create_result_record(
      start_time: @date.to_time + (60*60*12),
      end_time: @date.to_time + (60*60*14),
      where: "ジム#{n%3+1}",
      level: "#{n%2}",
    )
  end
end

ex_users = users[1..5]
ex_users.each do |u|
  3.times do |n|
    @date =  date.next_day(n)
    @activity = u.activities.create(
      title: "レベル#{n+1}に挑戦！",
      date: @date,
      description: "今日はレベル#{n+1}に挑戦！#{(n+1)*2}回ゴール達成するまで頑張ります！" 
    )
    @activity.create_commit_record(
      start_time: @date.to_time + (60*60*12),
      end_time: @date.to_time + (60*60*14),
      where: "ジム#{n%3+1}",
      level: "#{n%2}",
    )
    @activity.create_result_record(
      start_time: @date.to_time + (60*60*12),
      end_time: @date.to_time + (60*60*14),
      where: "ジム#{n%3+1}",
      level: "#{n%2}",
    )
  end
end
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
      gym_id: n%3+1,
      level: "#{n%2}",
    )
    @result = @activity.create_result_record(
      start_time: @date.to_time + (60*60*12),
      end_time: @date.to_time + (60*60*14),
      gym_id: n%3+1,
    )
    @result.create_level_count(
      level0: n*2+5-n,
      level1: n*2+4-n,
      level2: n*2+3-n,
      level3: n*2+2-n,
      level4: n*2+1-n,
    )
  when 1 then
    @activity.create_commit_record(
      start_time: @date.to_time + (60*60*12),
      end_time: @date.to_time + (60*60*14),
      gym_id: n%3+1,
      level: "#{n%2}",
    )
  when 2 then
    @result = @activity.create_result_record(
      start_time: @date.to_time + (60*60*12),
      end_time: @date.to_time + (60*60*14),
      gym_id: n%3+1,
    )
    @result.create_level_count(
      level5: n*2+5-n,
      level6: n*2+4-n,
      level7: n*2+3-n,
      level8: n*2+2-n,
      level9: n*2+1-n,
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
      gym_id: n%3+1,
      level: "#{n%2}",
    )
    @result = @activity.create_result_record(
      start_time: @date.to_time + (60*60*12),
      end_time: @date.to_time + (60*60*14),
      gym_id: n%3+1,
    )
    @result.create_level_count(
      level4: n*2+5+n,
      level5: n*2+4+n,
      level6: n*2+3+n,
      level7: n*2+2+n,
      level8: n*2+1+n,
      level9: n*2+n,
    )
  end
end
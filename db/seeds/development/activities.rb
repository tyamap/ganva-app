users = User.all
user  = users.first
date  = Date.new(2020, 3, 1)

10.times do |n|
  @date =  date.next_day(n)
  @level = n%2
  @activity = user.activities.create(
    date: @date,
    start_time: @date.to_time + (60*60*12),
    end_time: @date.to_time + (60*60*14),
    gym_id: n%3+1,
    level: @level,
    description: "今日はジム#{n%3+1}でレベル#{n%2}に挑戦！#{(n+1)*2}回ゴール達成するまで頑張ります！" ,
  )
  case n%3
    when 0 then
      @activity.create_level_count(
        level0: n*2+5-n,
        level1: n*2+4-n,
        level2: n*2+3-n,
        level3: n*2+2-n,
        level4: n*2+1-n,
      )
      @activity.status = 'recorded'
    when 1 then
      @activity.status = 'aborted'
    when 2 then
      @activity.status = 'done'
  end
  @activity.save
end

ex_users = users[1..3]
ex_users.each do |u|
  5.times do |n|

    @activity = u.activities.create(
      date: @date,
      start_time: @date.to_time + (60*60*12),
      end_time: @date.to_time + (60*60*14),
      gym_id: n%3+1,
      level: @level,
      description: "今日はジム#{n%2+1}でレベル#{n%3}に挑戦！#{(n+1)*2}回ゴール達成するまで頑張ります！",
    )
    case n%3
      when 0 then
        @activity.create_level_count(
          level5: n*2+3-n,
          level6: n*2+2-n,
          level7: n*2+1-n,
          level8: n*2+4-n,
          level9: n*2+5-n,
        )
        @activity.status = 'recorded'
      when 1 then
        @activity.status = 'aborted'
      when 2 then
        @activity.status = 'done'
    end
    @activity.save
  end
end
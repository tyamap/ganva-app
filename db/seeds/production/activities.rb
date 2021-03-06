users = User.all
user  = users.first
date  = Time.current
start_time  = '18:00'
end_time    = '20:00'

10.times do |n|
  @activity = user.activities.create(
    date: date.since(n.days).strftime('%Y-%m-%d'),
    start_time: start_time,
    end_time: end_time,
    gym: Gym.all[n%3],
    level: n%2,
    description: "#{Gym.all[n%3].name}でレベル#{n%2}に挑戦！" ,
  )
  case n%4
    when 0 then
      @activity.build_level_count(
        level0: n*2+5-n,
        level1: n*2+4-n,
        level2: n*2+3-n,
        level3: n*2+2-n,
        level4: n*2+1-n,
      )
      @activity.date = date.ago(n+1.days).strftime('%Y-%m-%d')
      @activity.status = Settings.activity.status.recorded
    when 1 then
      @activity.status = Settings.activity.status.aborted
    when 2 then
      @activity.date = date.ago(n+1.days).strftime('%Y-%m-%d')
      @activity.status = Settings.activity.status.done
  end
  @activity.save!
end

ex_users = users[1..3]
ex_users.each do |u|
  5.times do |n|

    @activity = u.activities.create(
      date: date.since(n.days).strftime('%Y-%m-%d'),
      start_time: start_time,
      end_time: end_time,
      gym_id: n%3+1,
      level: n%2,
      description: "今日はレベル#{n%3}に挑戦！#{(n+1)*2}回ゴール達成するまで頑張ります！",
    )
    case n%4
      when 0 then
        @activity.build_level_count(
          level5: n*2+3-n,
          level6: n*2+2-n,
          level7: n*2+1-n,
          level8: n*2+4-n,
          level9: n*2+5-n,
        )
        @activity.date = date.ago(n+1.days).strftime('%Y-%m-%d')
        @activity.status = Settings.activity.status.recorded
      when 1 then
        @activity.status = Settings.activity.status.aborted
      when 2 then
        @activity.date = date.ago(n+1.days).strftime('%Y-%m-%d')
        @activity.status = Settings.activity.status.done
    end
    @activity.save!
  end
end
# == Schema Information
#
# Table name: activities
#
#  id          :bigint           not null, primary key
#  date        :date             not null
#  description :text             default(""), not null
#  end_time    :time             not null
#  level       :string
#  start_time  :time             not null
#  status      :string           default("ready"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  gym_id      :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_activities_on_date_and_user_id  (date,user_id)
#  index_activities_on_gym_id            (gym_id)
#  index_activities_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (gym_id => gyms.id)
#  fk_rails_...  (user_id => users.id)
#
class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :gym, optional: true

  has_one :level_count, dependent: :destroy, autosave: true

  # 時刻の範囲チェック
  include TimerangeHolder
  include ActivityStatusHolder

  validates :gym, presence: true
  validates :date, presence: true, date: {
    after_or_equal_to: Date.new(2000, 1, 1),
    before: ->(_obj) { 1.year.from_now.to_date },
    allow_blank: true
  }

  # 開始日時をTime型で返す
  def start_datetime
    Time.zone.parse("#{date} #{start_time}")
  end

  # 終了日時をTime型で返す
  def end_datetime
    Time.zone.parse("#{date} #{end_time}")
  end
end

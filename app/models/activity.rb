class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :gym, optional: true

  has_one :level_count, dependent: :destroy, autosave: true

  # 時刻の範囲チェック
  include TimerangeHolder
  include ActivityStatusHolder

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

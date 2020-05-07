class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :gym, optional: true

  has_one :level_count, dependent: :destroy, autosave: true

  # 開始日時をTime型で返す
  def start_datetime
    Time.zone.parse("#{date} #{start_time}")
  end

  # 終了日時をTime型で返す
  def end_datetime
    Time.zone.parse("#{date} #{end_time}")
  end
end

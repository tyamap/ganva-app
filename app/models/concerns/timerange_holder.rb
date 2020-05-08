module TimerangeHolder
  extend ActiveSupport::Concern

  included do
    validates :start_time, presence: true, date: {
      allow_blank: true
    }
    validates :end_time, presence: true, date: {
      after: :start_time,
      allow_blank: true
    }
    validate :with_status
  end

  private

  def with_status
    case status
    when Settings.activity.status.ready
      errors.add(:start_time, '現在日時よりも後の日時を指定してください') if start_datetime < Time.current
    when Settings.activity.status.recorded
      errors.add(:end_time, '現在日時よりも前の日時を指定してください') if end_datetime > Time.current
    end
  end
end

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
      errors.add(:start_time, :cannot_be_before_current_time) if start_datetime < Time.current
    when Settings.activity.status.recorded
      errors.add(:end_time, :cannot_be_after_current_time) if end_datetime > Time.current
    end
  end
end

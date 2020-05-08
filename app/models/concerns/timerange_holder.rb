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
  end
end

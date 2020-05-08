module ActivityStatusHolder
  extend ActiveSupport::Concern

  included do
    validates :status, presence: true, inclusion: { in: Settings.activity.status.to_h.values }
  end
end
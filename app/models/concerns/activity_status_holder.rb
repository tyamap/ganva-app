module ActivityStatusHolder
  extend ActiveSupport::Concern

  included do
    validates :status, presence: true, inclusion: { in: Settings.activity.status.to_h.values }
    validate :able_to_change?, on: :update
  end

  private

  # statusの変更バリデーション：statusの整合性を保つ
  def able_to_change?
    case status_was
    when Settings.activity.status.recorded
      errors.add(:status, 'cannot change from recorded') if status != Settings.activity.status.recorded
    when Settings.activity.status.aborted
      errors.add(:status, 'cannot change from aborted') if status == Settings.activity.status.done ||
                                                           status == Settings.activity.status.recorded
    when Settings.activity.status.done
      errors.add(:status, 'cannot change from done') if status == Settings.activity.status.ready ||
                                                        status == Settings.activity.status.aborted
    end
  end
end

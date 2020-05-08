module ActivityStatusHolder
  extend ActiveSupport::Concern

  included do
    validates :status, presence: true, inclusion: { in: Settings.activity.status.to_h.values }
    validate :with_time
    validate :able_to_change?, on: :update
  end

  private

  def with_time
    case status
    when Settings.activity.status.aborted
      errors.add(:status, '終了日時が過ぎたものは中止できません') if end_datetime < Time.current
    when Settings.activity.status.done
      errors.add(:status, '開始日時に達していないものは完了できません') if start_datetime > Time.current
    end
  end

  # statusの変更バリデーション：statusの整合性を保つ
  def able_to_change?
    return if status_was == status

    case status_was
    when Settings.activity.status.recorded
      errors.add(:status, 'cannot change from recorded')
    when Settings.activity.status.aborted
      errors.add(:status, 'cannot change from aborted') if status != Settings.activity.status.ready
    when Settings.activity.status.done
      errors.add(:status, 'cannot change from done') if status != Settings.activity.status.recorded
    end
  end
end
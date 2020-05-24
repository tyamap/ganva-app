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
      errors.add(:status, '記録済みのものは変更できません。')
    when Settings.activity.status.aborted
      errors.add(:status, '中止済みのもは変更できません。') if status != Settings.activity.status.ready
    when Settings.activity.status.done
      errors.add(:status, '完了済みのものは変更できません。') if status != Settings.activity.status.recorded
    end
  end
end

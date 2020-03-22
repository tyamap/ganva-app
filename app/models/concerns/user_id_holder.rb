module UserIdHolder
  extend ActiveSupport::Concern

  included do
    include StringNormalizer

    before_validation do
      self.uid = normalize_as_uid(uid)
    end

    validates :uid, presence: true, uniqueness: { case_sensitive: false },
                    length: { maximum: 15 },
                    format: { with: /\A[\-_a-zA-Z\d]+\z/,
                              message: 'は英数字と「-」「_」のみ使用できます。' }
  end
end

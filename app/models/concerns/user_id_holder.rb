module UserIdHolder
  extend ActiveSupport::Concern

  included do
    include StringNormalizer

    before_validation do
      self.uid = normalize_as_uid(uid)
    end

    validates :uid, presence: true, uniqueness: { case_sensitive: false },
      format: { with: /\A[\-_a-zA-Z\d]+\z/ }, length: { maximum: 15 }
  end
end
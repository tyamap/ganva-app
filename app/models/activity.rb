class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :gym, optional: true

  has_one :level_count, dependent: :destroy, autosave: true
end

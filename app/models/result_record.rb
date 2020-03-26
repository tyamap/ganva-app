class ResultRecord < ApplicationRecord
  belongs_to :activity
  belongs_to :gym

  has_one :level_count, dependent: :destroy, autosave: true
end

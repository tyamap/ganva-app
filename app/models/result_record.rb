class ResultRecord < ApplicationRecord
  belongs_to :activity

  has_one :level_count, dependent: :destroy, autosave: true
end

class Activity < ApplicationRecord
  belongs_to :user
  
  has_one :level_count, dependent: :destroy, autosave: true
end

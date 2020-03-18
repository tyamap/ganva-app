class Activity < ApplicationRecord
  belongs_to :user

  has_one :commit_record, dependent: :destroy, autosave: true
  has_one :result_record, dependent: :destroy, autosave: true
end

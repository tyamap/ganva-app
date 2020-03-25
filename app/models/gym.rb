class Gym < ApplicationRecord
  has_one :level_name, dependent: :destroy, autosave: true
end

class CommitRecord < ApplicationRecord
  belongs_to :activity
  belongs_to :gym
end

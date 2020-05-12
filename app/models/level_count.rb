# == Schema Information
#
# Table name: level_counts
#
#  id          :bigint           not null, primary key
#  level0      :integer          default(0), not null
#  level1      :integer          default(0), not null
#  level2      :integer          default(0), not null
#  level3      :integer          default(0), not null
#  level4      :integer          default(0), not null
#  level5      :integer          default(0), not null
#  level6      :integer          default(0), not null
#  level7      :integer          default(0), not null
#  level8      :integer          default(0), not null
#  level9      :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  activity_id :bigint           not null
#
# Indexes
#
#  index_level_counts_on_activity_id  (activity_id)
#
class LevelCount < ApplicationRecord
  belongs_to :activity

  with_options presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 9999
  } do
    validates :level0
    validates :level1
    validates :level2
    validates :level3
    validates :level4
    validates :level5
    validates :level6
    validates :level7
    validates :level8
    validates :level9
  end
end

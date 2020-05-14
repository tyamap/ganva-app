# == Schema Information
#
# Table name: level_names
#
#  id         :bigint           not null, primary key
#  level0     :string           default("レベル1")
#  level1     :string           default("レベル2")
#  level2     :string           default("レベル3")
#  level3     :string           default("レベル4")
#  level4     :string           default("レベル5")
#  level5     :string           default("レベル6")
#  level6     :string           default("レベル7")
#  level7     :string           default("レベル8")
#  level8     :string           default("レベル9")
#  level9     :string           default("レベル10")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  gym_id     :bigint           not null
#
# Indexes
#
#  index_level_names_on_gym_id  (gym_id)
#
class LevelName < ApplicationRecord
  belongs_to :gym
end

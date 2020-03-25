class CreateLevelCounts < ActiveRecord::Migration[6.0]
  def change
    create_table :level_counts do |t|
      t.references   :result_record, null: false

      t.integer      :level0, null: false, default: 0
      t.integer      :level1, null: false, default: 0
      t.integer      :level2, null: false, default: 0
      t.integer      :level3, null: false, default: 0
      t.integer      :level4, null: false, default: 0
      t.integer      :level5, null: false, default: 0
      t.integer      :level6, null: false, default: 0
      t.integer      :level7, null: false, default: 0
      t.integer      :level8, null: false, default: 0
      t.integer      :level9, null: false, default: 0
      
      t.timestamps
    end
  end
end

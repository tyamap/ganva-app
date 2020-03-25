class CreateLevelNames < ActiveRecord::Migration[6.0]
  def change
    create_table :level_names do |t|
      t.references   :gym, null: false

      t.string       :level0, default: "レベル1"
      t.string       :level1, default: "レベル2"
      t.string       :level2, default: "レベル3"
      t.string       :level3, default: "レベル4"
      t.string       :level4, default: "レベル5"
      t.string       :level5, default: "レベル6"
      t.string       :level6, default: "レベル7"
      t.string       :level7, default: "レベル8"
      t.string       :level8, default: "レベル9"
      t.string       :level9, default: "レベル10"

      t.timestamps
    end
  end
end

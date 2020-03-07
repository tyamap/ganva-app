class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false
      t.string :experience, null: false    # 経験 
      t.string :frequency, null: false     # ボルダリング頻度
      t.string :level, null: false         # レベル
      t.string :status, null: false        # ステータス

      t.timestamps
    end
    add_index :profiles, [:level, :user_id], unique: true
    add_foreign_key :profiles, :users
  end
end

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false                # メールアドレス
      t.string :password_digest, null:false       # パスワード

      t.string :uid, null: false                  # アカウントID
      t.string :name, null: false, default: ''     # アカウント名

      t.string :experience, null: false, default: ''    # 経験 
      t.string :frequency, null: false, default: ''     # ボルダリング頻度
      t.string :level, null: false, default: ''         # レベル
      t.string :introduction, null:false, default: ''   # 自己紹介
      t.string :status, null: false, default: ''        # ステータス

      t.timestamps
    end
    add_index :users, 'LOWER(email)', unique: true
    add_index :users, 'LOWER(uid)', unique: true
  end
end

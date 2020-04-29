class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false                # メールアドレス
      t.string :password_digest, null:false       # パスワード

      t.string :uid, null: false                  # アカウントID
      t.string :name, null: false                 # アカウント名

      t.references :gym                   # マイジムID
      t.string :experience                # 経験年数 
      t.string :frequency                 # ボルダリング頻度
      t.string :level                     # レベル
      t.string :introduction              # 自己紹介

      t.string :status, null: false, default: 'stable'  # ステータス

      t.timestamps
    end
    add_index :users, 'LOWER(email)', unique: true
    add_index :users, 'LOWER(uid)', unique: true
  end
end

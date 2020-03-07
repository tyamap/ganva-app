class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false    # メールアドレス
      t.string :uid, null: false      # アカウントID
      t.string :name, null: false     # アカウント名

      t.string :hashed_password       # パスワード

      t.string :experience, null: false    # 経験 
      t.string :frequency, null: false     # ボルダリング頻度
      t.string :level, null: false         # レベル
      t.string :status, null: false        # ステータス
      t.string :introduction, null:false, default: ''

      t.timestamps
    end
    add_index :users, 'LOWER(email)', unique: true
    add_index :users, 'LOWER(uid)', unique: true
  end
end

class CreateGyms < ActiveRecord::Migration[6.0]
  def change
    create_table :gyms do |t|
      t.string :name, null: false
      t.string :postal_code, null: false
      t.string :prefecture, null: false
      t.string :city, null: false
      t.string :address1, null: false
      t.string :address2, null: false
      t.text   :introduction, null: false
      t.float  :latitude, null: false   # 緯度
      t.float  :longitude, null: false  # 経度

      t.timestamps
    end
    add_foreign_key :users, :gyms
    add_foreign_key :activities, :gyms
  end
end

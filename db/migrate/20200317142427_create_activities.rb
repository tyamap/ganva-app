class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.references  :user, null: false
      t.string      :type, null: false
      t.string      :name, null: false
      t.text        :description, null: false

      t.timestamps
    end

    add_index :activities, [ :type, :user_id ], unique: true
    add_foreign_key :activities, :users
  end
end

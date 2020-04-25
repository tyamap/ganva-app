class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.references  :user,        null: false
      t.string      :date,        null: false
      t.string      :start_time,  null: false
      t.string      :end_time,    null: false
      t.references  :gym,         null: false
      t.string      :level
      t.string      :status,      null: false, default: 'ready'
      t.text        :description, null: false, default: ''

      t.timestamps
    end

    add_index :activities, [ :date, :user_id ]
    add_foreign_key :activities, :users
  end
end

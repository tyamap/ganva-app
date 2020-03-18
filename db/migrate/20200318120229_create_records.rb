class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.references  :activity, null: false
      t.string      :type, null: false
      t.string      :start_time, null: false
      t.string      :end_time, null: false
      t.string      :where, null: false
      t.string      :level, null: false

      t.timestamps
    end
    
    add_index :records, [ :type, :activity_id ]
    add_foreign_key :records, :activities
  end
end

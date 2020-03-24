class CreateCommitRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :commit_records do |t|
      t.references  :activity, null: false
      t.string      :start_time, null: false
      t.string      :end_time, null: false
      t.string      :where, null: false
      t.string      :level, null: false

      t.timestamps
    end
  end
end

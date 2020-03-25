class CreateResultRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :result_records do |t|
      t.references   :activity, null: false
      t.string       :start_time, null: false
      t.string       :end_time, null: false
      t.string       :where, null: false

      t.timestamps
    end
  end
end

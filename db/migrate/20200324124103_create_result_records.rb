class CreateResultRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :result_records do |t|
      t.references   :activity, null: false
      t.string       :start_time, null: false
      t.string       :end_time, null: false
      t.string       :where, null: false
      t.integer      :cnt_vb, null: false, default: 0
      t.integer      :cnt_v0, null: false, default: 0
      t.integer      :cnt_v1, null: false, default: 0
      t.integer      :cnt_v2, null: false, default: 0
      t.integer      :cnt_v3, null: false, default: 0
      t.integer      :cnt_v4, null: false, default: 0
      t.integer      :cnt_v5, null: false, default: 0
      t.integer      :cnt_v6, null: false, default: 0
      t.integer      :cnt_v7, null: false, default: 0
      t.integer      :cnt_v8plus, null: false, default: 0

      t.timestamps
    end
  end
end

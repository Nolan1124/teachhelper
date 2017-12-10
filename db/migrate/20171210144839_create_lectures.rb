class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.integer :course_id
      t.string :name
      t.string :url
      t.string :secret_key
      t.boolean :is_shared, default: false
      t.datetime :gmt_time

      t.timestamps null: false
    end
  end
end

class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.integer :l_id
      t.integer :course_id
      t.string :name
      t.string :url
      t.string :secret_key
      t.boolean :is_shared, default: false
      t.datetime :gmt_time

      t.timestamps null: false
    end

    add_index :lectures, :l_id, unique: true

  end
end

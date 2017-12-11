class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :c_id
      t.integer :t_id
      t.integer :year
      t.integer :season
      t.datetime :gmt_time

      t.timestamps null: false
    end

    add_index :courses, :c_id, unique: true

  end
end

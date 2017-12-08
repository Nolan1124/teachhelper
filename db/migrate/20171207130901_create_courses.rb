class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :c_id
      t.belongs_to :teacher, index: true
      t.integer :year
      t.integer :season
      t.datetime :gmt_time

      t.timestamps null: false
    end
  end
end

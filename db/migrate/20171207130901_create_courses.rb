class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :teacher_id
      t.string :name
	  t.datetime :gmt_time

      t.timestamps null: false
    end
  
 end
end

class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :a_id
      t.integer :course_id
      t.string :description
      t.string :a_secret_key
      t.integer :duration
      t.datetime :gmt_time

      t.timestamps null: false
    end
  end
end

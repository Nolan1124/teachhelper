class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.integer :assignment_id
      t.string :student_answer
      t.string :student_id
      t.string :student_name
      t.integer :score
      t.datetime :gmt_time

      t.timestamps null: false
    end
  end
end

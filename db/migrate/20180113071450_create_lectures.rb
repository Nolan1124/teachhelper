class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.integer :course_id
      t.string :lecture_name
      t.string :url
      t.string :secret_key

      t.timestamps null: false
    end
  end
end

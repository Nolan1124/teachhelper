class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer  :course_id
      t.text     :content
      t.string   :answer
      t.string   :secret_key
      t.integer  :duration
      t.datetime :gmt_time

      t.timestamps null: false
    end
  end
end

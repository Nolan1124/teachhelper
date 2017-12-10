class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.integer :t_id
      t.string :username
      t.string :password
      t.string :email
      t.datetime :gmt_time
      t.timestamps null: false
    end
    
    add_index :teachers, :t_id, unique: true
    
  end
end

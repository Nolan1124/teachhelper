class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :sno
      t.string :sname
      t.integer :sage
      t.string :ssex
      t.string :sdept
      t.timestamps null: false
    end
    
     add_index :students, :sno, unique: true #建立索引
  end
end

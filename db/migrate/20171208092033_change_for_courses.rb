class ChangeForCourses < ActiveRecord::Migration
  def change
    #remove_column :courses, :teacher_id
    rename_column :courses, :teacher_id, :t_id
    change_column :courses, :t_id, :integer
  end
end

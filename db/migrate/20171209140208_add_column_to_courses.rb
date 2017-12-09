class AddColumnToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :cname, :string
  end
end

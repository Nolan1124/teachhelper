class AddIndexToAssignments < ActiveRecord::Migration
  def change
    add_index :assignments, :a_id, unique: true
  end
end

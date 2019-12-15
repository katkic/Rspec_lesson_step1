class ChangeIndexNameToTasks < ActiveRecord::Migration[5.2]
  def up
    remove_index :tasks, :name
    add_index :tasks, :name
  end

  def down
    remove_index :tasks, :name
    add_index :tasks, :name, unique: true
  end
end

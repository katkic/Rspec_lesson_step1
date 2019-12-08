class ChangeTasksExpirationAtNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :expired_at, false
  end
end

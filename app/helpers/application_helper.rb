module ApplicationHelper
  def create_statuses
    if action_name == 'new'
      Task.statuses_i18n.invert.delete_if { |_key, val| val == 'completed' }
    else
      Task.statuses_i18n.invert
    end
  end

  def which_user_path(path, current_user)
    path == 'admin/users' ? admin_user_path(current_user) : user_path(current_user)
  end
end

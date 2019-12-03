module ApplicationHelper
  def create_statuses
    if action_name == 'new'
      Task.statuses_i18n.invert.delete_if { |_key, val| val == 'completed' }
    else
      Task.statuses_i18n.invert
    end
  end
end

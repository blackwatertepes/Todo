module TasksHelper
  def crumbs task
    bread = task.ancestors.map do |ancestor|
      {name: ancestor.name, href: task_path(ancestor.id)}
    end
    bread.push({name: task.name, href: task_path(task)})
  end

  def version_desc version
    action = "created"
    action = "updated" if version.event == "update"
    time = time_ago_in_words version.created_at

    if version.whodunnit
      user = User.find version.whodunnit
      "#{user.first_name} #{user.last_name} #{action} this task #{time} ago"
    else
      "Task was #{action} #{time} ago"
    end
  end
end

module TasksHelper
  def crumbs task
    bread = task.ancestors.map do |ancestor|
      {name: ancestor.name, href: task_path(ancestor.id)}
    end
    bread.push({name: task.name, href: task_path(task)})
  end

  def version_desc version
    user = User.find version.whodunnit
    action = "created"
    action = "updated" if version.event == "update"
    "#{user.first_name} #{user.last_name} #{action} this task #{version.created_at}"
  end
end

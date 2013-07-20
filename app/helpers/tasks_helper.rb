module TasksHelper
  def crumbs task
    bread = task.ancestors.map do |ancestor|
      {name: ancestor.name, href: task_path(ancestor.id)}
    end
    bread.push({name: task.name, href: task_path(task)})
  end
end

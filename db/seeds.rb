# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Stage.delete_all
stages = [{name: :design, color: "#FAA"}, {name: :dev, color: "#FFA"}, {name: :test, color: "#AFA"}]
stages.map! do |stage|
  Stage.create name: stage[:name], color: stage[:color]
end

Task.delete_all
[:basic, :completed, :blocked, :tree].each do |task_type|
  ([nil] + stages).each do |stage|
    name = stage ? "#{task_type.capitalize} #{stage.name.capitalize} Task" : "#{task_type.capitalize} Task" 
    case task_type
    when :basic
      Task.create name: name, stage: stage
    when :completed
      Task.create name: name, completed: true, stage: stage
    when :blocked
      blocked_task = Task.create name: name, stage: stage
      pre_task = Task.first
      Prereq.create task_id: blocked_task.id, prereq_id: pre_task.id
    when :tree
      task = Task.create name: name, stage: stage
      rand(20).times do |i|
        task.children.create name: "Child #{name} #{i}"
      end
      if rand(2)
        task.children.each do |child|
          rand(2).times do |j|
            child.children.create name: "Grandchild #{name} Task #{j}"
          end
        end
      end
    end
  end
end

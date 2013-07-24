# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# 
puts "Creating me..."
User.delete_all
users_me = [{email: "tyler@wargoats.com", first_name: "Tyler", last_name: "Kuhn", password: "password"},{email: "blackwatertepes@gmail.com", first_name: "Black", last_name: "Water", password: "password"}].map do |user|
   User.create user
 end

puts "Creating users..."
users = []
10.times do |user|
  users << User.create(email: Faker::Internet.email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: "password")
end

puts "Creating companies..."
Company.delete_all
companies = [{name: "Wargoats, Inc."}].map do |company|
  Company.create company
end

puts "Creating employees..."
Employee.delete_all
employee_titles = ["Software Developer", "Marketing Manager", "Content Producer"]
users.each do |user|
  company = companies.first
  company.employees << Employee.create(user: user, title: employee_titles.sample)
end

puts "Creating teams..."
Team.delete_all
teams = [{name: "Officers"}, {name: "Strategy"}, {name: "Engineering"}, {name: "Quality Assurance"}].map do |team|
  company = companies.first
  team = Team.new(team)
  company.teams << team
  3.times do
    employee = company.employees.sample
    member = Member.new
    employee.members << member
    team.members << member
  end
  leader = team.members.sample
  leader.leader = true
  leader.save
  team
end

puts "Creating projects..."
Project.delete_all
Manager.delete_all
projects = [{name: "Platform"}, {name: "Dynamic"}, {name: "Marketing"}].map do |project|
  project = Project.create(project)
  company = companies.first
  company.projects << project 
  employee = company.employees.sample
  manager = Manager.new
  employee.managers << manager
  project.managers << manager
  # project.teams << teams.sample
  project
end

puts "Creating stages..."
Stage.delete_all
stages = [{name: :design, color: "#FAA"},{name: :dev, color: "#FFA"},{name: :test, color: "#AFA"}].map do |stage|
  Stage.create stage
end

puts "Injecting me..."
me = users_me.first
company = companies.first
project = projects.first
employee = Employee.create(user: me, title: employee_titles.first)
manager = Manager.new
company.employees << employee
employee.managers << manager
project.managers << manager

puts "Creating tasks..."
projects.each do |project|
  10.times do
    task = Task.new(name: Faker::Lorem.sentence, completed: rand(2), stage: stages.sample)
    project.tasks << task
  end
end

puts "..."
# My personal tasks
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

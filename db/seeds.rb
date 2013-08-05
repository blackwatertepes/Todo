puts "Creating companies..."
User.delete_all
Company.delete_all
Employee.delete_all
companies = [
   {email: "blackwatertepes@gmail.com"},
   {email: "tyler@wargoats.com", name: "War Goats", admin: true, title: "Founder"},
   {email: "tyler.kuhn@spongecell.com", name: "Spongecell", admin: false, title: "Developer"}]
companies.map! do |c|
   user = User.create(email: c[:email], first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: "password")
   company = Company.create(name: c[:name]) if c[:name]

  if company && c[:admin] && c[:title]
     employee = Employee.new(admin: c[:admin], title: c[:title], user: user) 
     company.employees << employee
  end
  company
end

companies.compact!

puts "Creating users..."
users = []
100.times do |user|
  users << User.new(email: Faker::Internet.email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: "password")
end

puts "Creating employees..."
employee_titles = ["Software Developer", "Marketing Manager", "Content Producer", "Sales"]
users.each do |user|
  company = companies.sample
  company.employees << Employee.new(user: user, title: employee_titles.sample)
end

puts "Creating teams..."
Team.delete_all
Member.delete_all
adjs = ["Services", "Product", "Super"]
companies.each do |company|
  teams = ["Strategy", "Engineering", "Quality Assurance"].map do |team|
    adjs.each do |adj|
      team = Team.create(name: "#{adj} #{team}", company: company)
    end
    team
  end

  company.employees.each do |employee|
    team = company.teams.sample
    member = Member.new
    employee.members << member
    team.members << member
  end

  teams.each do |team|
    leader = team.members.sample
    leader.leader = true
    leader.save
  end
end

puts "Creating projects..."
Project.delete_all
Manager.delete_all
companies.each do |company|
  projects = ["Platform", "Dynamic", "Marketing"].map do |project|
    adjs.each do |adj|
      project = Project.create(name: "#{adj} #{project}", company: company)
      employee = company.employees.sample
      manager = Manager.new
      employee.managers << manager
      project.managers << manager
      company.teams.shuffle.take(3).each do |team|
        project.teams << team
      end
    end
    project
  end
end

puts "Creating stages..."
Stage.delete_all
stages = [{name: :design, color: "#FAA"},{name: :dev, color: "#FFA"},{name: :test, color: "#AFA"}].map do |stage|
  Stage.create stage
end

puts "Creating tasks..."
Task.delete_all
companies.each do |company|
  company.projects.each do |project|
    100.times do
      task = Task.new(name: Faker::Lorem.sentence, completed: rand(2), stage: stages.sample)
      project.tasks << task
    end
  end
end

puts "and more..."
# My personal tasks
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

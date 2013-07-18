# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Stage.delete_all
[:design, :dev, :test].each do |stage|
  Stage.create name: stage
end

Task.delete_all
100.times do |i|
  Task.create name: "Task #{i}", stage: Stage.all.sample
end

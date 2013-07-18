class AddMilstoneAndSprintToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :milestone, :boolean
    add_column :tasks, :sprint, :boolean
  end
end

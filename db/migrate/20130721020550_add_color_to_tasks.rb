class AddColorToTasks < ActiveRecord::Migration
  def change
    add_column :stages, :color, :string
  end
end

class Task < ActiveRecord::Base
  attr_accessible :completed, :name

  has_many :subtasks, class_name: :Task, foreign_key: :parent_id
  belongs_to :task, foreign_key: :parent_id

  def complete!
    self.completed = true
    self
  end

  def uncomplete!
    self.completed = false
    self
  end

  def complete?
    self.completed
  end
end

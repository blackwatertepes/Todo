class Task < ActiveRecord::Base
  has_ancestry orphan_strategy: :destroy
  acts_as_list

  attr_accessible :completed, :name, :parent_id

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

  def milestone?
    self.milestone
  end

  def sprint?
    self.sprint
  end
end

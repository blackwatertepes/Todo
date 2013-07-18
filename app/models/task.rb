class Task < ActiveRecord::Base
  has_ancestry orphan_strategy: :destroy

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
end

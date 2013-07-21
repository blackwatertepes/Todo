class Task < ActiveRecord::Base
  has_ancestry orphan_strategy: :destroy
  acts_as_list

  attr_accessible :completed, :name, :parent_id, :stage

  has_many :prereqs
  has_many :reqs, through: :prereqs
  belongs_to :stage

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

  def open?
    reqs.each do |req|
      return false unless req.complete?
    end
    true
  end

  def closed?
    !open?
 end

  def status
    return :open if open?
    :closed
  end

  def stages
    return [] unless stage
    Stage.all.map do |s|
      status = s.id == stage.id ? :on : :off
      s.class.module_eval { attr_accessor :status }
      s.status = status
      s
    end
  end
end

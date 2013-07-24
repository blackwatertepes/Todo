class Task < ActiveRecord::Base
  has_ancestry orphan_strategy: :destroy
  acts_as_list
  has_paper_trail
  acts_as_commentable

  attr_accessible :completed, :name, :parent_id, :stage, :user_id

  belongs_to :stage
  belongs_to :user
  belongs_to :project

  has_many :prereqs
  has_many :reqs, through: :prereqs

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

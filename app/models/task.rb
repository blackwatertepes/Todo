# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  completed  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ancestry   :string(255)
#  position   :integer
#  stage_id   :integer
#  user_id    :integer
#  project_id :integer
#

class Task < ActiveRecord::Base
  has_ancestry orphan_strategy: :destroy
  acts_as_list
  has_paper_trail
  acts_as_commentable

  attr_accessible :completed, :name, :parent_id, :stage, :user_id, :project_id

  belongs_to :stage
  belongs_to :user
  belongs_to :project

  has_many :prereqs
  has_many :reqs, through: :prereqs

  scope :root, -> { order(:position).roots }

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
      return false if req.open?
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

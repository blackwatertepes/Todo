class Prereq < ActiveRecord::Base
  attr_accessible :prereq_id, :task_id

  belongs_to :task
  belongs_to :req, class_name: :Task, foreign_key: :prereq_id
end

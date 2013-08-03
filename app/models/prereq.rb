# == Schema Information
#
# Table name: prereqs
#
#  id         :integer          not null, primary key
#  task_id    :integer
#  prereq_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Prereq < ActiveRecord::Base
  attr_accessible :prereq_id, :task_id

  belongs_to :task
  belongs_to :req, class_name: :Task, foreign_key: :prereq_id
end

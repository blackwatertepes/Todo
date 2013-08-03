# == Schema Information
#
# Table name: managers
#
#  id          :integer          not null, primary key
#  employee_id :integer
#  project_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Manager < ActiveRecord::Base
  attr_accessible :employee

  belongs_to :employee
  belongs_to :project
end

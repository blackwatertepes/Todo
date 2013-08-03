# == Schema Information
#
# Table name: members
#
#  id          :integer          not null, primary key
#  team_id     :integer
#  employee_id :integer
#  leader      :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Member < ActiveRecord::Base
  belongs_to :team
  belongs_to :employee
  attr_accessible :leader
end

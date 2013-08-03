# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  company_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Team < ActiveRecord::Base
  attr_accessible :name

  belongs_to :company
  has_and_belongs_to_many :projects
  has_many :members
  has_many :employees, through: :members
end

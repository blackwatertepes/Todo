# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  company_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Project < ActiveRecord::Base
  attr_accessible :name, :company

  belongs_to :company
  has_many :tasks, dependent: destroy
  has_many :managers, dependent: :destroy
  has_and_belongs_to_many :teams
end

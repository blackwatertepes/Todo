# == Schema Information
#
# Table name: employees
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  admin      :boolean
#  user_id    :integer
#  company_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Employee < ActiveRecord::Base
  attr_accessible :admin, :title, :user, :company

  belongs_to :user
  belongs_to :company
  has_many :members, dependent: :destroy
  has_many :managers, dependent: :destroy
  has_many :projects, through: :managers
  has_many :teams, through: :members
end

class Team < ActiveRecord::Base
  attr_accessible :name

  belongs_to :company
  has_and_belongs_to_many :projects
  has_many :members
  has_many :employees, through: :members
end

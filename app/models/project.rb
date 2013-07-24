class Project < ActiveRecord::Base
  attr_accessible :name

  belongs_to :company
  has_many :tasks
  has_many :managers
  has_and_belongs_to_many :teams
end

class Company < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  has_many :teams
  has_many :projects
  has_many :employees
end

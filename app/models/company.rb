class Company < ActiveRecord::Base
  attr_accessible :name
  has_many :teams
  has_many :projects
  has_many :employees
end

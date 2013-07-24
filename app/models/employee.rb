class Employee < ActiveRecord::Base
  attr_accessible :admin, :title, :user

  belongs_to :user
  belongs_to :company
  has_many :members
  has_many :managers
  has_many :projects, through: :managers
  has_many :teams, through: :members
end

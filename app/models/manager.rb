class Manager < ActiveRecord::Base
  attr_accessible :employee

  belongs_to :employee
  belongs_to :project
end

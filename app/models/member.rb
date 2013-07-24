class Member < ActiveRecord::Base
  belongs_to :team
  belongs_to :employee
  attr_accessible :leader
end

# == Schema Information
#
# Table name: stages
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  color      :string(255)
#

class Stage < ActiveRecord::Base
  attr_accessible :name, :color

  has_many :tasks
end

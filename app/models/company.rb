# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Company < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  has_many :teams, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :employees, dependent: :destroy
end

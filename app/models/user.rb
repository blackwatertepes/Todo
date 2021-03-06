# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me

  acts_as_voter

  has_many :tasks
  has_many :employees
  has_many :companies, through: :employees
  belongs_to :company, foreign_key: :current_company_id
  
  def current_company_name
    company ? company.name : "Personal"
  end

  def employee
    company ? employees.by_company(company).first : "NA"
  end

  def teams
    company ? employee.teams : "NA"
  end

  def projects
    if company
      teams.includes(projects: {tasks: [:stage, :reqs]}).map{|team| team.projects}.flatten.uniq
    else
      project = Project.new(name: "Personal")
      project.tasks = personal_tasks
      [project]
    end
  end

  def current_tasks
    company ? company_tasks : personal_tasks
  end

  def archived_tasks
    personal_tasks.where(completed: true, ancestry: nil)
  end

  def company_tasks
    projects.map{|project| project.tasks}.flatten.uniq.sort{|a,b| a.likes.size <=> b.likes.size}.reverse
  end

  def personal_tasks
    tasks.where(project_id: nil, ancestry: nil)
  end
end

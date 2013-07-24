class ProjectsTeam < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :project
  belongs_to :team
end

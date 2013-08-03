# == Schema Information
#
# Table name: projects_teams
#
#  id         :integer          not null, primary key
#  project_id :integer
#  team_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProjectsTeam < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :project
  belongs_to :team
end

class CreateProjectsTeams < ActiveRecord::Migration
  def change
    create_table :projects_teams do |t|
      t.references :project
      t.references :team
    end
    add_index :projects_teams, :project_id
    add_index :projects_teams, :team_id
  end
end

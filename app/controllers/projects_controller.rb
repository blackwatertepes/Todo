class ProjectsController < ApplicationController
  expose(:project)
  expose(:projects)

  load_and_authorize_resource
end

class TeamsController < ApplicationController
  expose(:team)
  expose(:teams)

  load_and_authorize_resource
end

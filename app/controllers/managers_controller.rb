class ManagersController < ApplicationController
  expose(:manager)
  expose(:managers)

  load_and_authorize_resource
end

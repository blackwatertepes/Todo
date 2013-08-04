class MembersController < ApplicationController
  expose(:member)
  expose(:members)

  load_and_authorize_resource
end

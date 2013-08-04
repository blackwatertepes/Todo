class EmployeesController < ApplicationController
  expose(:employee)
  expose(:employees)

  load_and_authorize_resource
end

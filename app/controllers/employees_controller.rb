class EmployeesController < ApplicationController
  expose(:employee)
  expose(:employees)

  load_and_authorize_resource

  def index
    @company = Company.find(params[:id])
    @employees = @company.employees
  end
end

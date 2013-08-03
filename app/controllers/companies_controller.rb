class CompaniesController < ApplicationController
  expose(:company)
  expose(:companies)

  def create
    team = Team.new company: company
    project = Project.new company: company
    employee = Employee.new admin: true, user: current_user, company: company

    if company.save && team.save && project.save && employee.save
      redirect_to :back
    else
      render :index
    end
  end
end

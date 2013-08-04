class CompaniesController < ApplicationController
  expose(:company)

  load_and_authorize_resource

  def index
    @companies = current_user.companies
  end

  def create
    team = Team.new(name: "Basic", company: company)
    project = Project.new(name: "Basic", company: company)
    employee = Employee.new(admin: true, user: current_user, company: company)

    if company.save && team.save && project.save && employee.save
      redirect_to :back
    else
      render :index
    end
  end

  def enter
    current_user.current_company_id = params[:company_id]
    if current_user.save
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def leave
    current_user.current_company_id = nil
    if current_user.save
      redirect_to :back
    else
      redirect_to :back
    end
  end
end

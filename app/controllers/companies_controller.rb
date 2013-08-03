class CompaniesController < ApplicationController
  expose(:company)
  expose(:companies)

  def create
    if company.save
      redirect_to :back
    else
      render :index
    end
  end
end

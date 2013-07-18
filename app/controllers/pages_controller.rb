class PagesController < ApplicationController
  def index
    @task = Task.new
    @tasks = Task.order(:position).roots
  end
end

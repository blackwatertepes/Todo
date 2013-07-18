class PagesController < ApplicationController
  def index
    @task = Task.new
    @tasks = Task.roots
  end
end

class PagesController < ApplicationController
  def index
    @stages = Stage.all
    @tasks = current_user.current_tasks.take(10)
  end
end

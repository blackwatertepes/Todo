class PagesController < ApplicationController
  def index
    @stages = Stage.all
    @tasks = current_user.current_tasks.take(10)
    @archived_tasks = current_user.archived_tasks.take(10)
  end

  def search
  	tasks = Task.search(params[:term]).results.map do |task|
  		{name: task.name}
  	end
  	render json: tasks.to_json
  end
end

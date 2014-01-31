class PagesController < ApplicationController
  def index
    @stages = Stage.all
    @tasks = current_user.current_tasks.take(10)
  end

  def search
  	tasks = Task.search(params[:term]).records.map{|task| task.name}
  	puts tasks.to_json
  	render json: tasks.to_json
  end
end

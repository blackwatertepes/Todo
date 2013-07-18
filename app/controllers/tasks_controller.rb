class TasksController < ApplicationController
  def create
    Task.create params[:task]
    redirect_to :root
  end
  
  def destroy
    Task.find(params[:id]).destroy
    redirect_to :root
  end
  
  def complete
    Task.find(params[:task_id]).complete!.save
    redirect_to :root
  end

  def uncomplete
    Task.find(params[:task_id]).uncomplete!.save
    redirect_to :root
  end

  def up
    @task = Task.find(params[:task_id])
    @task.move_higher
    redirect_to :root
  end

  def down
    @task = Task.find(params[:task_id])
    @task.move_lower
    redirect_to :root
  end
end

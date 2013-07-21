class TasksController < ApplicationController
  def create
    parent_id = params[:task].delete(:parent_id)
    if parent_id
      task = Task.find(parent_id)
      task.children.create params[:task]
      redirect_to task_path(parent_id)
    else
      Task.create params[:task]
      redirect_to root_path
    end
  end

  def show
    @task = Task.find(params[:id])
    @tasks = @task.children
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

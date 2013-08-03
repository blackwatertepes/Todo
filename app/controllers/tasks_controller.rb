class TasksController < ApplicationController
  def create
    parent_id = params[:task].delete(:parent_id)
    params[:task].merge! user_id: current_user.id
    if parent_id && !parent_id.blank?
      task = Task.find(parent_id)
      task.children.create params[:task]
    else
      Task.create params[:task]
    end
    redirect_to :back
  end

  def show
    @task = Task.find(params[:id])
    @tasks = @task.children
  end
  
  def destroy
    task = Task.find(params[:id])
    if task.root?
      task.destroy
      redirect_to :root
    else
      parent_id = task.parent_id
      task.destroy
      redirect_to task_path(parent_id)
    end
  end
  
  def complete
    Task.find(params[:task_id]).complete!.save
    redirect_to :back
  end

  def uncomplete
    Task.find(params[:task_id]).uncomplete!.save
    redirect_to :back
  end

  def up
    @task = Task.find(params[:task_id])
    @task.move_higher
    redirect_to :back
  end

  def down
    @task = Task.find(params[:task_id])
    @task.move_lower
    redirect_to :back
  end
end

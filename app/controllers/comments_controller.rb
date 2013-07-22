class CommentsController < ApplicationController
  def create
    task = Task.find params[:comment].delete :task_id
    params[:comment].merge! user_id: current_user.id
    task.comments.create params[:comment]
    redirect_to :back
  end
end

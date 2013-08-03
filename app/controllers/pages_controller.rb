class PagesController < ApplicationController
  def index
    @tasks = current_user.tasks.order(:position).roots
  end
end

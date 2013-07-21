class PagesController < ApplicationController
  def index
    @tasks = Task.order(:position).roots
  end
end

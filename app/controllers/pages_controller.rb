class PagesController < ApplicationController
  def index
    @stages = Stage.all
  end
end

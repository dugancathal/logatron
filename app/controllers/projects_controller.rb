class ProjectsController < ApplicationController
  def index
    render json: Project.all.pluck(:name)
  end

  def create
    render json: Project.create!(name: params[:name])
  end
end

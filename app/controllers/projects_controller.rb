class ProjectsController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @projects = Project.published
  end

  def show
    @project = Project.published.where(slug: params[:id]).to_a.first
  end

  def new
    @project = Project.new
  end

  def create
    params.require(:project).permit!
    @project = Project.new(params[:project])
    @project.user_id = current_user.id
    @project.save
    redirect_to @project
  end
end

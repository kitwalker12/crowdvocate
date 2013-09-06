class ProjectsController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :find_project, except: [:index, :new, :create]

  def index
    @projects = Project.published
  end

  def show
  end

  def new
    @project = Project.new
  end

  def create
    params.require(:project).permit!
    @project = current_user.projects.build(params[:project])
    @project.save
    redirect_to @project
  end

  def edit
  end

  def update
    params.require(:project).permit!
    if @project.update_attributes(params[:project])
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
  end

  private
    def find_project
      @project = Project.published.find_by_slug!(params[:id].split("/").last)
    end
end

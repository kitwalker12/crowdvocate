class ProjectsController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :find_project, except: [:index, :new, :create]

  def index
    @projects = Project.published
  end

  def show
    if @project.pledged_users.include?(current_user)
      @pledge = @project.pledges.where(:user => current_user).first
    else
      @pledge = Pledge.new
    end
  end

  def new
    @project = Project.new
  end

  def create
    params.require(:project).permit!
    @project = current_user.projects.build(params[:project])
    if @project.save
      flash[:notice] = "Successfully created Pitch"
    else
      flash[:alert] = "Could not save Pitch"
      redirect_to :back and return
    end
    #To be changed to user.projects page
    redirect_to action: 'index'
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

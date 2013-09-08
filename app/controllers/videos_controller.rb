class VideosController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :find_project
  before_filter :find_video, except: [:index, :new, :create]

  def index
  end

  def create
    params.require(:video).permit!
    @video = @project.videos.build(params[:video])
    if @video.save
      flash[:notice] = "Successfully added Video"
      current_user.videos << @video
    else
      flash[:alert] = "Could not add Video"
      redirect_to @project and return
    end
    redirect_to project_video_path(@project,@video)
  end

  def new
    @video = Video.new
  end

  def edit
  end

  def show
  end

  def update
    params.require(:video).permit!
    if @video.update_attributes(params[:video])
      flash[:notice] = "Successfully updated Video"
    else
      flash[:alert] = "Could not update Video"
      redirect_to @project and return
    end
    redirect_to project_video_path(@project,@video)
  end

  def destroy
    @video.destroy
    flash[:notice] = "Video deleted"
    redirect_to @project
  end

  private
    def find_project
      @project = Project.published.find_by_slug!(params[:project_id].split("/").last)
    end

    def find_video
      @video = @project.videos.find(params[:id])
    end
end
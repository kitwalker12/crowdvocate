class VotesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_project
  before_filter :find_video

  def create
    @vote = Vote.new
    @vote.user = current_user
    @vote.project = @project
    @vote.video = @video
    if @vote.save
      flash[:notice] = "Successfully saved your Vote"
    else
      flash[:alert] = "Could not save your Vote"
    end
    redirect_to @project
  end

  def destroy
    @vote = @video.votes.find(params[:id])
    @vote.destroy
    flash[:notice] = "Vote Removed"
    redirect_to @project
  end

  private
    def find_project
      @project = Project.published.find_by_slug!(params[:project_id].split("/").last)
    end

    def find_video
      @video = @project.videos.find(params[:video_id])
    end
end
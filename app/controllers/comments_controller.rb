class CommentsController < ApplicationController

  before_filter :authenticate_user!, except: [:show]
  before_filter :find_project
  before_filter :find_event

  def create
    params.require(:comment).permit!
    @comment = @event.comments.build(params[:comment])
    if @comment.save
      flash[:notice] = "Successfully added Comment"
      current_user.comments << @comment
    else
      flash[:alert] = "Could not add Comment"
    end
    redirect_to project_event_path(@project, @event)
  end

  private
    def find_project
      @project = Project.published.find_by_slug!(params[:project_id].split("/").last)
    end

    def find_event
      @event = @project.events.find(params[:event_id])
    end
end

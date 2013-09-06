class EventsController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :find_project
  before_filter :find_event, except: [:index, :new, :create]

  def index
    @events = @project.events
  end

  def show
    @comment = Comment.new
  end

  def new
    @event = Event.new
  end

  def create
    params.require(:event).permit!
    @event = @project.events.build(params[:event])
    current_user.events << @event
    @event.save
    redirect_to project_event_path(@project, @event)
  end

  def edit
  end

  def update
    params.require(:event).permit!
    if @event.update_attributes(params[:event])
      redirect_to project_event_path(@project, @event)
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
  end

  private
    def find_project
      @project = Project.published.find_by_slug!(params[:project_id].split("/").last)
    end

    def find_event
      @event = @project.events.find(params[:id])
    end
end

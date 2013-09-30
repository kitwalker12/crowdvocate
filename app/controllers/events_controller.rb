class EventsController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :find_project
  before_filter :find_event, except: [:index, :new, :create]
  before_filter :authorize_user, only: [:new, :edit, :create, :update]

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
    if @event.save
      flash[:notice] = "Successfully created Event"
      current_user.events << @event
    else
      flash[:alert] = "Could not add Event"
      redirect_to @project and return
    end
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

    def authorize_user
      if @project.user != current_user
        flash[:alert] = "You do not have permission to create an event on this Pitch!"
        redirect_to @project and return
      end
    end
end

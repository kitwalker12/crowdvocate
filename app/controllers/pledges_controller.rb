class PledgesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :find_project
  before_filter :find_pledge, only: [:update]

  def create
    params.require(:pledge).permit!
    @pledge = current_user.pledges.build(params[:pledge])
    @pledge.project = @project
    if @pledge.save
      flash[:notice] = "Thank you for pledging #{@pledge.amount}"
    else
      flash[:alert] = "Could not add funds"
    end
    redirect_to @project
  end

  def update
    params.require(:pledge).permit!
    @pledge.amount = params[:pledge][:amount]
    if @pledge.save
      flash[:notice] = "Thank you for pledging #{@pledge.amount}"
    else
      flash[:alert] = "Could not add funds"
    end
    redirect_to @project
  end

  private
    def find_project
      @project = Project.published.find_by_slug!(params[:project_id].split("/").last)
    end

    def find_pledge
      @pledge = @project.pledges.find(params[:id])
    end
end
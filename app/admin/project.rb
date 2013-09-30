ActiveAdmin.register Project do

  before_filter :only => [:show, :edit, :update] do
    @project = Project.find_by_slug(params[:id])
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end

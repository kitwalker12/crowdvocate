class AddUserandProjectAssocToVideos < ActiveRecord::Migration
  def change
    add_reference :videos, :user, index: true
    add_reference :videos, :project, index: true
  end
end

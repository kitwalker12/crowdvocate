class AddProjectAssocToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :project, index: true
  end
end

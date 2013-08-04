class AddPublishedToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :published, :boolean
    add_column :projects, :published_at, :datetime
  end
end

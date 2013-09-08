class ChangeLengthForUrlToVideos < ActiveRecord::Migration
  def change
    change_column :videos, :url, :text, :limit => nil
  end
end

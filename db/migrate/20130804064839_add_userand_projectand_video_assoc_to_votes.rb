class AddUserandProjectandVideoAssocToVotes < ActiveRecord::Migration
  def change
    add_reference :votes, :user, index: true
    add_reference :votes, :project, index: true
    add_reference :votes, :video, index: true
  end
end

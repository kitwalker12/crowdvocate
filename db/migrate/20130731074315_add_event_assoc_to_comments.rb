class AddEventAssocToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :event, index: true
  end
end

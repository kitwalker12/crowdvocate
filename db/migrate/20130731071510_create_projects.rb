class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.text :body
      t.string :slug
      t.integer :goal
      t.datetime :deadline

      t.timestamps
    end
  end
end

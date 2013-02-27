class AddProjectIdToEpicsAndStories < ActiveRecord::Migration
  def change
    add_column :epics, :project_id, :integer
    add_column :stories, :project_id, :integer
    add_index :epics, :project_id
    add_index :stories, :project_id
  end
end

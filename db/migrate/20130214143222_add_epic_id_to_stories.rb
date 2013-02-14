class AddEpicIdToStories < ActiveRecord::Migration
  def change
    add_column :stories, :epic_id, :integer
    add_index :stories, :epic_id
  end
end

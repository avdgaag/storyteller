class AddStoriesCountToEpics < ActiveRecord::Migration
  def change
    add_column :epics, :stories_count, :integer, default: 0
  end
end

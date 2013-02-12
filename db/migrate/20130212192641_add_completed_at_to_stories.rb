class AddCompletedAtToStories < ActiveRecord::Migration
  def change
    add_column :stories, :completed_at, :datetime
  end
end

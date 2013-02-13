class AddRequirementsCountToStories < ActiveRecord::Migration
  def change
    add_column :stories, :requirements_count, :integer, default: 0
  end
end

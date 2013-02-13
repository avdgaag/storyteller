class AddOwnerIdToStories < ActiveRecord::Migration
  def change
    add_column :stories, :owner_id, :integer
    add_index :stories, :owner_id
  end
end

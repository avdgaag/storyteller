class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title, null: false
      t.text :body
      t.references :user
      t.timestamps
    end
    add_index :stories, :user_id
  end
end

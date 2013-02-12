class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.string :title, null: false
      t.datetime :completed_at
      t.integer :story_id, null: false
      t.timestamps
    end
    add_index :requirements, :story_id
  end
end

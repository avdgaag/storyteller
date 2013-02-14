class CreateEpics < ActiveRecord::Migration
  def change
    create_table :epics do |t|
      t.string :title, null: false
      t.text :body
      t.integer :author_id, null: false
      t.timestamps
    end
    add_index :epics, :author_id
  end
end

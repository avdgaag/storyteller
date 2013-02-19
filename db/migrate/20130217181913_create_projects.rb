class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.integer :owner_id

      t.timestamps
    end
    add_index :projects, :owner_id
  end
end

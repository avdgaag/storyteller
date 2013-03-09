class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.references :project
      t.references :user
      t.timestamps
    end

    add_index :collaborations, :project_id
    add_index :collaborations, :user_id
  end
end

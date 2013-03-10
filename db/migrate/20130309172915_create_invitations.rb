class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :email, null: false
      t.string :token, null: false
      t.references :project, null: false
      t.timestamps
    end
    add_index :invitations, :project_id
    add_index :invitations, :token
  end
end

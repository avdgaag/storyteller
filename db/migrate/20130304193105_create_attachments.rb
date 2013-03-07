class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :attachable_id,  null: false
      t.string :attachable_type, null: false
      t.integer :user_id,        null: false
      t.timestamps
    end
    add_index :attachments, [:attachable_id, :attachable_type]
    add_index :attachments, :user_id
    add_attachment :attachments, :file
  end
end

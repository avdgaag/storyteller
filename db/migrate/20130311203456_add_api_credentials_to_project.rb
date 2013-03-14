class AddApiCredentialsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :token, :string
    add_column :projects, :external_id, :string
  end
end

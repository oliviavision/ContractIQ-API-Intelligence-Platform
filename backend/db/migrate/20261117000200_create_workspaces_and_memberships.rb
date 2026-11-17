class CreateWorkspacesAndMemberships < ActiveRecord::Migration[8.1]
  def change
    create_table :workspaces do |t|
      t.string :name, null: false
      t.text :description
      t.timestamps
    end
    create_table :workspace_memberships do |t|
      t.references :workspace, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :role, null: false, default: "developer"
      t.timestamps
    end
    add_index :workspace_memberships, %i[workspace_id user_id], unique: true
  end
end

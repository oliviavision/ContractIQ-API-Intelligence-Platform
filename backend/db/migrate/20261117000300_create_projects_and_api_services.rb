class CreateProjectsAndApiServices < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.references :workspace, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.timestamps
    end
    add_index :projects, %i[workspace_id name], unique: true
    create_table :api_services do |t|
      t.references :project, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.string :repository_url
      t.timestamps
    end
    add_index :api_services, %i[project_id name], unique: true
  end
end

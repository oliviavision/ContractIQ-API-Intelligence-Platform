class CreateSpecificationVersions < ActiveRecord::Migration[8.1]
  def change
    create_table :specification_versions do |t|
      t.references :api_service, null: false, foreign_key: true
      t.references :uploaded_by, null: false, foreign_key: { to_table: :users }
      t.string :format, null: false
      t.string :source, null: false, default: "upload"
      t.string :content_hash, null: false
      t.string :storage_key, null: false
      t.boolean :baseline, null: false, default: false
      t.timestamps
    end
    add_index :specification_versions, %i[api_service_id content_hash], unique: true
  end
end

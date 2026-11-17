class CreateAnalysisRunsAndFindings < ActiveRecord::Migration[8.1]
  def change
    create_table :analysis_runs do |t|
      t.references :workspace, null: false, foreign_key: true
      t.references :baseline_version, null: false, foreign_key: { to_table: :specification_versions }
      t.references :candidate_version, null: false, foreign_key: { to_table: :specification_versions }
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.string :status, null: false, default: "queued"
      t.jsonb :summary, null: false, default: {}
      t.text :error_summary
      t.timestamps
    end
    create_table :findings do |t|
      t.references :analysis_run, null: false, foreign_key: true
      t.string :rule_id, null: false
      t.string :classification, null: false
      t.string :severity, null: false
      t.string :title, null: false
      t.text :rationale
      t.string :affected_element
      t.jsonb :evidence, null: false, default: {}
      t.timestamps
    end
    add_index :findings, %i[analysis_run_id rule_id]
  end
end

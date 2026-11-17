class Finding < ApplicationRecord
  SEVERITIES = %w[critical high medium low info].freeze
  CLASSIFICATIONS = %w[breaking potentially_breaking non_breaking informational].freeze
  belongs_to :analysis_run
  validates :rule_id, :title, :classification, :severity, presence: true
  validates :classification, inclusion: { in: CLASSIFICATIONS }
  validates :severity, inclusion: { in: SEVERITIES }
end

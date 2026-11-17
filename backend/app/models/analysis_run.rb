class AnalysisRun < ApplicationRecord
  STATUSES = %w[queued running succeeded failed cancelled].freeze
  belongs_to :workspace
  belongs_to :baseline_version, class_name: "SpecificationVersion"
  belongs_to :candidate_version, class_name: "SpecificationVersion"
  belongs_to :created_by, class_name: "User"
  has_many :findings, dependent: :destroy
  validates :status, inclusion: { in: STATUSES }
end

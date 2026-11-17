class SpecificationVersion < ApplicationRecord
  belongs_to :api_service
  belongs_to :uploaded_by, class_name: "User"
  validates :format, inclusion: { in: %w[json yaml] }
  validates :content_hash, presence: true, uniqueness: { scope: :api_service_id }
end

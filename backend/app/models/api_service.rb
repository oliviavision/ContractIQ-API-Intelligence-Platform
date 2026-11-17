class ApiService < ApplicationRecord
  belongs_to :project
  has_many :specification_versions, dependent: :destroy
  validates :name, presence: true, length: { maximum: 160 }
  validates :repository_url, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }, allow_blank: true
end

class Project < ApplicationRecord
  belongs_to :workspace
  has_many :api_services, dependent: :destroy
  validates :name, presence: true, length: { maximum: 120 }
end

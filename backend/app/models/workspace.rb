class Workspace < ApplicationRecord
  has_many :workspace_memberships, dependent: :destroy
  has_many :users, through: :workspace_memberships
  has_many :projects, dependent: :destroy
  validates :name, presence: true, length: { maximum: 120 }
end

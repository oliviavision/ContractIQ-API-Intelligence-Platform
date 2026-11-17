class WorkspaceMembership < ApplicationRecord
  ROLES = %w[owner admin developer viewer].freeze
  belongs_to :user
  belongs_to :workspace
  validates :role, inclusion: { in: ROLES }
  validates :user_id, uniqueness: { scope: :workspace_id }
end

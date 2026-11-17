class User < ApplicationRecord
  has_secure_password
  has_many :workspace_memberships, dependent: :destroy
  has_many :workspaces, through: :workspace_memberships
  has_many :projects, through: :workspaces
  before_validation { self.email = email.to_s.downcase.strip }
  validates :name, presence: true, length: { maximum: 120 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 10 }, if: -> { password.present? }
end

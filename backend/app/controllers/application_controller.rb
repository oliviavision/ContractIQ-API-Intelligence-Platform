class ApplicationController < ActionController::API
  include ApiAuthentication
  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound do
    render json: { error: { code: "not_found", message: "The requested resource was not found." } }, status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid do |error|
    render json: { error: { code: "validation_error", message: "The submitted data is invalid.", details: error.record.errors.to_hash } }, status: :unprocessable_entity
  end

  private

  def render_unauthorized
    render json: { error: { code: "unauthorized", message: "Authentication is required." } }, status: :unauthorized
  end
end

module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :authenticate_user!, only: %i[register login], raise: false
      def register
        user = User.new(user_params)
        if user.save
          render json: { user: user_payload(user), token: issue_token(user) }, status: :created
        else
          render json: { error: { code: "validation_error", details: user.errors.to_hash } }, status: :unprocessable_entity
        end
      end
      def login
        user = User.find_by(email: params[:email].to_s.downcase.strip)
        if user&.authenticate(params[:password])
          render json: { user: user_payload(user), token: issue_token(user) }
        else
          render json: { error: { code: "invalid_credentials", message: "Email or password is incorrect." } }, status: :unauthorized
        end
      end
      def logout
        head :no_content
      end
      private
      def user_params = params.permit(:name, :email, :password, :password_confirmation)
      def user_payload(user) = { id: user.id, name: user.name, email: user.email }
    end
  end
end

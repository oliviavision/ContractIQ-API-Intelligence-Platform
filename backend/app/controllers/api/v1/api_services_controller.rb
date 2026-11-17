module Api
  module V1
    class ApiServicesController < ApplicationController
      before_action :authenticate_user!
      def index
        render json: { services: accessible_project.api_services.order(:name) }
      end
      def create
        service = accessible_project.api_services.new(params.permit(:name, :description, :repository_url))
        service.save!
        render json: { service: service }, status: :created
      end
      private
      def accessible_project = current_user.projects.find(params[:project_id])
    end
  end
end

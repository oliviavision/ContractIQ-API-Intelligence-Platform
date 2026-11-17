module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authenticate_user!
      def index
        workspace = current_user.workspaces.find(params[:workspace_id])
        render json: { projects: workspace.projects.order(:name) }
      end
      def create
        workspace = current_user.workspaces.find(params[:workspace_id])
        project = workspace.projects.new(params.permit(:name, :description))
        project.save!
        render json: { project: project }, status: :created
      end
    end
  end
end

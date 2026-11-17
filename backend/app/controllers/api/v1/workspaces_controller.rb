module Api
  module V1
    class WorkspacesController < ApplicationController
      before_action :authenticate_user!
      def index
        render json: { workspaces: current_user.workspaces.map { |w| payload(w) } }
      end
      def show
        render json: { workspace: payload(current_user.workspaces.find(params[:id])) }
      end
      def create
        workspace = Workspace.new(workspace_params)
        Workspace.transaction do
          workspace.save!
          workspace.workspace_memberships.create!(user: current_user, role: "owner")
        end
        render json: { workspace: payload(workspace) }, status: :created
      end
      private
      def workspace_params = params.permit(:name, :description)
      def payload(w) = { id: w.id, name: w.name, description: w.description, role: w.workspace_memberships.find_by(user: current_user)&.role }
    end
  end
end

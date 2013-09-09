class StatusReportsController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource
  before_filter :check_organization_status

  def index
    @status_reports = current_user.status_reports.order("created_at DESC")
  end

  def show
    @status_report = @current_organization.status_reports.find(params[:id])
  end
end

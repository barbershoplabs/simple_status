class StatusReportsController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource

  def index
    @status_reports = current_user.status_reports
  end

  def show
    @status_report = @current_organization.status_reports.find(params[:id])
  end
end

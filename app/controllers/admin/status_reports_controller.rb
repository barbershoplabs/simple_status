class Admin::StatusReportsController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource

  def index
    @status_reports = @current_organization.status_reports.order("created_at DESC")
  end

  def show
    @status_report = @current_organization.status_reports.find(params[:id])
  end

  def new
    @status_report = StatusReport.new
  end

  def edit
    @status_report = @current_organization.status_reports.find(params[:id])
  end

  def update
    @status_report = @current_organization.status_reports.find(params[:id])

    respond_to do |format|
      if @status_report.update_attributes(status_report_params)
        format.html { redirect_to admin_customer_root_url, notice: "Status report updated" }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def create
    @status_report = StatusReport.new(status_report_params)
    @status_report.organization_id = @current_organization.id

    respond_to do |format|
      if @status_report.save
        format.html { redirect_to admin_customer_root_url, notice: "Status report created" }
        format.json { render json: @status_report, status: :created, location: @status_report }
      else
        format.html { render action: "new" }
        format.json { render json: @status_report.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @status_report = @current_organization.status_reports.find(params[:id])
    @status_report.destroy

    respond_to do |format|
      format.html { redirect_to admin_customer_root_url, notice: "Status report deleted" }
    end
  end

  private

  def status_report_params
    params.require(:status_report).permit(:organization_id, :team_id)
  end
end

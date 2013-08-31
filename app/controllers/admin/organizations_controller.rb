class Admin::OrganizationsController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource

  def show
    @organization = @current_organization
  end

  def edit
    @organization = @current_organization
  end

  def update
    @organization = Organization.find(params[:id])

    respond_to do |format|
      if @organization.update_attributes(organization_params)
        format.html { redirect_to admin_organization_path(@organization), notice: "#{@organization.subdomain} was successfully updated." }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @organization = @current_organization
    @organization.destroy

    respond_to do |format|
      format.html { redirect_to master_root_path, notice: "#{@organization.subdomain} was successfully deleted." }
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :subdomain, :plan_id, :status)
  end
end

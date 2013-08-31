class Sadmin::OrganizationsController < ApplicationController
  before_filter :authenticate_user!
  # authorize_resource

  def index
    @organizations = Organization.all
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])

    respond_to do |format|
      if @organization.update_attributes(organization_params)
        format.html { redirect_to sadmin_organizations_path, notice: "#{@organization.subdomain} was successfully updated." }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy

    respond_to do |format|
      format.html { redirect_to sadmin_organizations_path, notice: "#{@organization.subdomain} was successfully deleted." }
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :subdomain, :stripe_customer_id, :plan_id, :trial_expiration_date, :status)
  end
end

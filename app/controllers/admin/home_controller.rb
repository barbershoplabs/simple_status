class Admin::HomeController < ApplicationController
  def index
    authorize!(:index, :customer_home)

    @teams = Team.where(organization_id: @current_organization.id)
  end
end

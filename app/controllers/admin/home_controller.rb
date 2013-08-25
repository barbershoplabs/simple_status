class Admin::HomeController < ApplicationController
  def index
    authorize!(:index, :admin_home)

    @teams = Team.where(organization_id: @current_organization.id)
  end
end

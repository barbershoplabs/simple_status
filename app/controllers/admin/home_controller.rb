class Admin::HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize!(:index, :admin_home)
    @teams = @current_organization.teams
  end
end

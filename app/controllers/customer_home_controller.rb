class CustomerHomeController < ApplicationController
  def index
    authorize!(:index, :customer_home)

    @team_memberships = current_user.team_memberships
  end
end

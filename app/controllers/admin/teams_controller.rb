class Admin::TeamsController < ApplicationController
  def new
    @team = Team.new
    @team.team_memberships.build(email: current_user.email)
    2.times do
      @team.team_memberships.build
    end
  end

  def create
    @team = Team.new(team_params)
    @team.organization_id = @current_organization.id

    respond_to do |format|
      if @team.save
        format.html { redirect_to admin_customer_root_url, notice: "Team created" }
        format.json { render json: @team, status: :created, location: @team }
      else
        format.html { render action: "new" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, team_memberships_attributes: [:email, :_destroy])
  end
end

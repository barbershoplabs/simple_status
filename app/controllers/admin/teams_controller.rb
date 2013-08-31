class Admin::TeamsController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource

  def index
    @teams = @current_organization.teams
  end

  def new
    @team = Team.new
    @team.recurrence_value = 5
    @team.send_request_at = Time.now.change({:hour => 11 , :min => 0 , :sec => 0 })
    @team.send_digest_days_later = 3
    @team.send_digest_at = Time.now.change({:hour => 11 , :min => 0 , :sec => 0 })

    @team.team_memberships.build(email: current_user.email)
    2.times do
      @team.team_memberships.build
    end
  end

  def edit
    @team = @current_organization.teams.find(params[:id])
  end

  def update
    @team = @current_organization.teams.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(team_params)
        format.html { redirect_to admin_teams_url, notice: "Team updated" }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def create
    if @current_organization.teams_remaining_per_plan?
      @team = Team.new(team_params)
      @team.organization_id = @current_organization.id

      respond_to do |format|
        if @team.save
          format.html { redirect_to admin_teams_url, notice: "Team created" }
          format.json { render json: @team, status: :created, location: @team }
        else
          format.html { render action: "new" }
          format.json { render json: @team.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to admin_home_url, alert: "You've already created the maximum number of teams for your plan"
    end
  end

  def destroy
    @team = @current_organization.teams.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to admin_teams_url, notice: "Team deleted" }
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :recurrence_type, :recurrence_value, :send_request_at, :send_digest_days_later, :send_digest_at, :timezone, team_memberships_attributes: [:id, :email, :user_id, :team_id, :_destroy])
  end
end

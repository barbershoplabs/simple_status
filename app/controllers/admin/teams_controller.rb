class Admin::TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  def create
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end
end

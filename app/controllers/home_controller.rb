class HomeController < ApplicationController
  def index

  end

  def show
    @plans = Plan.active  if params[:page] == "pricing"

    respond_to do |format|
      format.html { render params[:page] }
    end
  end
end

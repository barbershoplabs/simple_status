class Sadmin::PlansController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource

	def index
		@plans = Plan.all
	end

	def new
		@plan = Plan.new
	end

	def create
		@plan = Plan.new(plan_params)

		respond_to do |format|
			if @plan.save
				format.html { redirect_to sadmin_plans_url, notice: "Plan created" }
				format.json { render json: @plan, status: :created, location: @plan }
			else
				format.html { render action: "new" }
				format.json { render json: @plan.errors, status: :unprocessable_entity }
			end
		end
	end

	def show
		@plan = Plan.find(params[:id])
	end

	def edit
		@plan = Plan.find(params[:id])
	end

	def update
		@plan = Plan.find(params[:id])

		respond_to do |format|
			if @plan.update_attributes(plan_params)
				format.html { redirect_to sadmin_plans_path, notice: "#{@plan.name} was successfully updated." }
			else
				format.html { render action: "edit" }
			end
		end
	end

	def destroy
		@plan = Plan.find(params[:id])
		@plan.destroy

		respond_to do |format|
			format.html { redirect_to sadmin_plans_path, notice: "#{@plan.name} was successfully deleted." }
		end
	end

	private

	def plan_params
		params.require(:plan).permit(:name, :description, :amount, :interval, :interval_count, :days_free, :status)
  end
end

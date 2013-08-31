class OrganizationsController < ApplicationController
  def new
    @plan = Plan.find(params[:plan])
    @organization = Organization.new
    @organization.users.build
  end

  def create
    @organization = Organization.new(organization_params)
    token = params[:stripeToken]

    # set trial_expiration_date
    customer = Stripe::Customer.create(
      :card => token,
      :plan => "simple_status_plan_#{@organization.plan_id}"
    )

    @organization.stripe_customer_id = customer.id
    @organization.status = Organization::STATUSES[:active]
    @organization.name = @organization.subdomain

    respond_to do |format|
      if @organization.save

        if current_user
          membership = Membership.create(user_id: current_user.id, organization_id: @organization.id, role: "owner")
        else
          current_user = @organization.users.first
          membership = Membership.where("organization_id = ?", @organization.id).first
          membership.role = "owner"
          membership.save
          sign_in(current_user)
        end

        OrganizationMailer.welcome_email(@organization, membership.user).deliver

        format.html { redirect_to(admin_customer_root_url(subdomain: @organization.subdomain)) }
        format.json { render json: @organization, status: :created, location: @organization }
      else
        format.html { render action: "new" }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def organization_params
  	params.require(:organization).permit(:subdomain, :name, :plan_id, users_attributes: [:email, :password, :password_confirmation])
  end

end

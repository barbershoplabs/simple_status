class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	before_filter :load_organization
	layout :set_layout

	def load_organization
    if request.subdomain.present? && request.subdomain != "www"
    	@current_organization = Organization.find_by_subdomain(request.subdomain)
    	ActionMailer::Base.default_url_options = { host: request.host_with_port }

      # if @current_organization.blank?
      # 	flash[:error] = "Sorry, we can't find that site."
      #   redirect_to customer_root_url(subdomain: "www")
      # end
    end
  end

  def set_layout
    if controller_path.starts_with?("admin/") || controller_path.starts_with?("htadmin/")
      "application"
  	elsif @current_organization.present?
  		"customer"
  	else
  		"public_website"
  	end
  end

  def current_membership
    if current_user
      memberships = current_user.memberships.where("organization_id = ?", @current_organization.id)
      memberships.first
    end
  end
  helper_method :current_membership

  private

  def current_ability
  	@current_ability ||= Ability.new(current_user, current_membership)
  end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	before_filter :load_organization
  # before_filter :check_access
	layout :set_layout

	def load_organization
    if request.subdomain.present? && request.subdomain != "www"
    	@current_organization = Organization.where(subdomain: request.subdomain).first
    	ActionMailer::Base.default_url_options = { host: request.host_with_port }
    end
  end

  def check_organization_status
    if @current_organization.inactive?
      respond_to do |format|
        format.html { render template: "/organizations/inactive" }
      end
    end
  end


  def set_layout
    if controller_path.starts_with?("admin/") || controller_path.starts_with?("sadmin/")
      "application"
  	elsif @current_organization.present?
  		"customer"
  	else
  		"public_website"
  	end
  end

  def current_membership
    if current_user && @current_organization
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

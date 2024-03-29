class Ability
	include CanCan::Ability

	def initialize(user, membership)
		@user = user || User.new
		@membership = membership || Membership.new
		role_name = @membership.role.present? ? @membership.role : "guest"

		send(role_name)
	end

	def guest
    # can [:create], User
    can :index, :customer_home
  end

  def member
  	guest
    can [:index, :show], StatusReport

#  	can :read, Site
#  	can :update, User, id: @user.id
  end

  def admin
  	member
    can :index , :admin_home
    can :manage, Team, organization_id: @membership.organization_id
    can :manage, StatusReport, organization_id: @membership.organization_id
    can [:show, :update, :destroy], Organization, organization_id: @membership.organization_id
  end

  def owner
  	admin
  end

  def god
  	can :manage, :all
  end
end


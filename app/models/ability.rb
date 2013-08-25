class Ability
	include CanCan::Ability

	def initialize(user, membership)
		@user = user || User.new
		@membership = membership || Membership.new
		role_name = @membership.role.present? ? @membership.role : "guest"

		send(role_name)
	end

	def guest
    can [:create], User
    can :index, :customer_home
  end

  def member
  	guest
#  	can :read, Site
#  	can :read, User
#  	can :update, User, id: @user.id
  end

  def subscriber
    member
  end

  def admin
  	subscriber
  end

  def owner
  	admin
#  	can :index , :admin_home
#  	can :update, :sites
    # can :manage, :admin_screener_choices
  end

  def god
  	can :manage, :all
  end
end


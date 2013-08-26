class TeamMembership < ActiveRecord::Base
	belongs_to :user
	belongs_to :team

  attr_reader :email
  attr_writer :email

  before_create :create_team_memberships_from_email_addresses


  def email
    user.email if user.present?
  end

  def create_team_memberships_from_email_addresses
    if self.email.present?
      user = User.where(email: self.email.downcase).first

      if user.present?
        self.user_id = user.id
        organization = user.organizations.where(id: self.team.organization.id).first

        unless organization.present?
          Membership.create(user_id: self.user_id, organization_id: self.team.organization.id, role: "member")
        end
      else
        # create a new user, membership, and add them to the team
        user = User.invite!(email: self.email)
        self.user_id = user.id
        Membership.create(user_id: self.user_id, organization_id: self.team.organization.id, role: "member")
      end
    end
  end
end

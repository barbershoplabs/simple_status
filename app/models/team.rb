class Team < ActiveRecord::Base
  RECURRENCE_TYPES = ["Weekly"]

  belongs_to :organization
  has_many :team_memberships, dependent: :destroy
  has_many :users, through: :team_memberships
  has_many :status_reports, dependent: :destroy

  validates :name, presence: true, format: { with: /\A[a-zA-Z\d ]+\z/, message: "can only contain letters and numbers and spaces." }

  accepts_nested_attributes_for :team_memberships, :reject_if => :all_blank, :allow_destroy => true

  after_create :create_on_mailgun
  # after_save :update_on_mailgun
  after_destroy :destroy_on_mailgun

  def email
    "#{self.organization.subdomain.downcase}.#{self.name.downcase.tr(' ','-')}@adamrubin.mailgun.org"
  end

  def create_on_mailgun
    route = MailgunConfig.client.routes.create "Route for #{self.organization.subdomain} / #{self.name}", 1,
     [:match_recipient, self.email],
     [[:forward, "http://2c7ce99a.ngrok.com/incoming"],[:stop]]

     self.mailgun_route = route
     self.save
  end

  def destroy_on_mailgun
    MailgunConfig.client.routes.destroy "#{self.mailgun_route}"
  end

  def self.team_from_email(email)
    (organization, team_part) = email.split(".")
    team = team_part.split("@")[0]

    Team.joins(:organization).where("organizations.subdomain = ? and teams.name = ?", organization, team.tr('-',' ')).first
  end

end

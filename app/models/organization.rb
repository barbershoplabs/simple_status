class Organization < ActiveRecord::Base
  STATUSES = { inactive: 0, active: 1 }

  belongs_to :plan
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :teams, dependent: :destroy
  has_many :status_reports, dependent: :destroy

  accepts_nested_attributes_for :users

  validates_format_of :subdomain, :with => /[a-zA-Z\d]*/i,:message => "can only contain letters and numbers. No special characters or spaces, please."

  def owner
    memberships.where("role = ?", "owner").first.user
  end

  def teams_remaining_per_plan?
    teams.count < Plan::CONSTRAINTS[plan.name.to_sym][:teams] ? true : false
  end
end

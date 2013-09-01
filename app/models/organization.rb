class Organization < ActiveRecord::Base
  STATUSES = { inactive: 0, active: 1 }

  belongs_to :plan
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :teams, dependent: :destroy
  has_many :status_reports, dependent: :destroy

  after_save :change_on_stripe

  accepts_nested_attributes_for :users

  validates_format_of :subdomain, :with => /[a-zA-Z\d]*/i,:message => "can only contain letters and numbers. No special characters or spaces, please."

  STATUSES.keys.each do |status|
    scope status, -> { where("status = ?", STATUSES[status]) }
  end

  def inactive?
    STATUSES[:inactive] == self.status ? true : false
  end

  def active?
    STATUSES[:active] == self.status ? true : false
  end

  def owner
    memberships.where("role = ?", "owner").first.user
  end

  def teams_remaining_per_plan?
    teams.count < Plan::CONSTRAINTS[plan.name.to_sym][:teams] ? true : false
  end

  def change_on_stripe
    if status_changed?
      if inactive?
        customer = Stripe::Customer.retrieve(stripe_customer_id)
        customer.cancel_subscription
      elsif active?
        customer = Stripe::Customer.retrieve(stripe_customer_id)
        customer.update_subscription(plan: "simple_status_plan_#{self.plan_id}")
      end
    end

    if plan_id_changed?
      customer = Stripe::Customer.retrieve(stripe_customer_id)
      customer.update_subscription(plan: "simple_status_plan_#{self.plan_id}")
    end
  end
end

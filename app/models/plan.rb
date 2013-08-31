class Plan < ActiveRecord::Base
  has_many :organizations
  after_create :create_on_stripe
  after_save :update_on_stripe
  after_destroy :destroy_on_stripe

  STATUSES = { inactive: 0, active: 1 }
  CONSTRAINTS = { basic: { teams: 1 }, premium: { teams: 5 }, enterprise: { teams: 100000 } }

  STATUSES.keys.each do |status|
    scope status, -> { where("status = ?", STATUSES[status]) }
  end

	def create_on_stripe
    Stripe::Plan.create(
      amount: self.amount,
      interval: self.interval,
      interval_count: self.interval_count,
      trial_period_days: self.days_free,
      name: self.name,
      currency: 'usd',
      id: "simple_status_plan_#{self.id}"
    )
  end

  def update_on_stripe
    p = Stripe::Plan.retrieve("simple_status_plan_#{self.id}")
    # meh, only the name is editable via the stripe API.
    p.name = self.name
    p.save
  end

  def destroy_on_stripe
    p = Stripe::Plan.retrieve("simple_status_plan_#{self.id}")
    p.delete
  end
end

module PlansHelper
  def display_price(plan)
    number_to_currency(plan.amount/100)
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization do
    name ""
    subdomain ""
    stripe_customer_id ""
    plan_id ""
    trial_expiration_date "2013-08-24 20:41:08"
  end
end

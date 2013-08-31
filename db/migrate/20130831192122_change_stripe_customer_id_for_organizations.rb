class ChangeStripeCustomerIdForOrganizations < ActiveRecord::Migration
  def up
    remove_column :organizations, :stripe_customer_id
    add_column :organizations, :stripe_customer_id, :string
  end

  def down
    remove_column :organizations, :stripe_customer_id
    add_column :organizations, :stripe_customer_id, :integer
  end
end

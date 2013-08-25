class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :subdomain
      t.integer :stripe_customer_id
      t.integer :plan_id
      t.datetime :trial_expiration_date

      t.timestamps
    end
  end
end

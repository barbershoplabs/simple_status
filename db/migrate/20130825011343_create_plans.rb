class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|

	    t.string   "name"
	    t.integer  "amount"
	    t.string   "interval", default: "month"
	    t.integer  "status"
	    t.integer  "days_free", default: 30
	    t.text     "description"
	    t.integer  "interval_count", default: 1

      t.timestamps
    end
  end
end

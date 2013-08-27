class CreateStatusSummaries < ActiveRecord::Migration
  def change
    create_table :status_summaries do |t|
      t.integer :status_report_id
      t.integer :user_id
      t.text :body

      t.timestamps
    end
  end
end

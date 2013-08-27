class CreateStatusReports < ActiveRecord::Migration
  def change
    create_table :status_reports do |t|
      t.integer :team_id
      t.integer :organization_id

      t.timestamps
    end
  end
end

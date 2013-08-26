class AddRecurrenceToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :recurrence_type, :string
    add_column :teams, :recurrence_value, :integer
    add_column :teams, :send_request_at, :time
    add_column :teams, :send_digest_days_later, :integer
    add_column :teams, :send_digest_at, :time
    add_column :teams, :timezone, :string
    add_column :teams, :status, :string
  end
end

class AddSentReminderAtToStatusReports < ActiveRecord::Migration
  def change
    add_column :status_reports, :sent_reminder_at, :datetime
  end
end

class AddSentDigestAtToStatusReports < ActiveRecord::Migration
  def change
    add_column :status_reports, :sent_digest_at, :datetime
  end
end

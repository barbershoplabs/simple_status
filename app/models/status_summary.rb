class StatusSummary < ActiveRecord::Base
  belongs_to :status_report
  belongs_to :user
end

namespace :scheduler do
  desc "Check to see if any status reports need to be sent out"
  task :send_status_reports => :environment do
    StatusReport.send_status_reports
  end
end

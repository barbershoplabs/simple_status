namespace :scheduler do
  desc "Check to see if any status reports need to be sent out"
  task :send_status_report_requests => :environment do
    StatusReport.send_status_report_requests
  end

  desc "Check to see if any status report reminders need to be sent out"
  task :send_status_report_requests_reminder => :environment do
    StatusReport.send_status_report_requests_reminder
  end

  desc "Check to see if any status report digests need to be sent out"
  task :send_status_report_digests => :environment do
    StatusReport.send_status_report_digests
  end
end

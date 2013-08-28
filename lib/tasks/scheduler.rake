namespace :scheduler do
  desc "Check to see if any status reports need to be sent out"
  task :send_status_reports => :environment do
    StatusReport.send_status_reports
  end

  desc "Check to see if any status report digests need to be sent out"
  task :send_status_report_digests => :environment do
    StatusReport.send_status_report_digests
  end
end

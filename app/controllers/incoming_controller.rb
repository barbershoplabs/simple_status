class IncomingController < ApplicationController
  protect_from_forgery :except => :create

  def create
    email_recipient = params["recipient"] ||= ""
    email_sender = params["sender"] ||= ""

    email_from = params["from"] ||= ""
    email_from = email_from.split("<")[1].split(">")[0]

    email_stripped_text = params["stripped-text"] ||= ""
    email_date = params["Date"] ||= ""
    email_orig = params["body-plain"] ||= ""

    email_report_token = ""

    if email_orig.present?
      email_report_token = email_orig.match(/Status Report:(.*)/).to_s
      email_report_token = email_report_token.split("Status Report: ")[1].split("\r")[0]
    end

    # puts "Email recipient: #{email_recipient}"
    # puts "Email sender: #{email_sender}"
    # puts "Email text: #{email_stripped_text}"
    # puts "Email date: #{email_date}"
    # puts "Token: #{email_report_token}"

    puts "EMAIL RECIPIENT IS: #{email_recipient}"
    team = Team.team_from_email(email_recipient)
    puts "TEAM IS: #{team.inspect}"
    if team.present?
      status_report = team.status_reports.where(token: email_report_token).first

      if status_report.present?
        puts "STATUS REPORT IS: #{status_report.inspect}"
        user = team.users.where(email: email_from).first
        puts "USER IS: #{user.inspect}"
        StatusSummary.create(status_report_id: status_report.id, user_id: user.id, body: email_stripped_text) if user.present?
      end
    end

    render :text => "Success", :status => 200
  end
end

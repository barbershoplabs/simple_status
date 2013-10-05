class TeamMailer < ActionMailer::Base
  default from: "no-reply@simplestatus.io"

  def status_report_request_email(team, organization, token)
    @team = team
    @organization = organization
    @token = token
    mail(from: @team.email, to: 'no-reply@simplestatus.io', bcc: @team.users.pluck(:email), subject: "[#{@team.name.titleize}] status report request")
  end

  def status_report_request_reminder_email(status_report)
    @status_report = status_report
    @team = @status_report.team
    @organization = @status_report.organization
    @token = @status_report.token

    @status_summaries = @status_report.status_summaries
    @no_response_from = @team.users.pluck(:email) - @status_report.users.pluck(:email)

    puts "NO RESPONSE FROM: #{@no_response_from}"

    mail(from: @team.email, to: 'no-reply@simplestatus.io', bcc: @no_response_from, subject: "[#{@team.name.titleize}] status report request (reminder)")
  end

  def status_report_digest_email(status_report)
    @status_report = status_report
    @team = @status_report.team
    @status_summaries = @status_report.status_summaries
    @no_response_from = @team.users - @status_report.users

    mail(from: @team.email, to: 'no-reply@simplestatus.io', bcc: @team.users.pluck(:email), subject: "[#{@team.name.titleize}] status report digest")
  end
end

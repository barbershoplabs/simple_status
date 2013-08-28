class TeamMailer < ActionMailer::Base
  default from: "no-reply@simplestatus.io"

  def status_report_email(team, organization, token)
    @team = team
    @organization = organization
    @token = token
    mail(from: @team.email, to: @team.users.pluck(:email), subject: "[#{@team.name}] status report request")
  end

  def status_report_digest_email(status_report)
    @status_report = status_report
    @team = @status_report.team
    @status_summaries = @status_report.status_summaries
    @no_response_from = @team.users - @status_report.users

    mail(from: @team.email, to: @team.users.pluck(:email), subject: "[#{@team.name}] status report digest")
  end
end

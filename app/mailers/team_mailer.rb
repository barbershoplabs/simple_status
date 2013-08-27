class TeamMailer < ActionMailer::Base
  default from: "no-reply@simplestatus.io"

  def status_report_email(team, organization, token)
    @team = team
    @organization = organization
    @token = token
    mail(from: @team.email, to: @team.users.pluck(:email), subject: "[#{@team.name}] status report request")
  end
end

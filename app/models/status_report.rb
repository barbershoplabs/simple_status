class StatusReport < ActiveRecord::Base
  belongs_to :team
  belongs_to :organization
  has_many :status_summaries

  before_create do
    generate_token(:token)
  end
  after_create :send_status_report_email


  def send_status_report_email
    TeamMailer.status_report_email(self.team, self.organization, self.token).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while StatusReport.exists?(column => self[column])
  end

  def self.send_status_reports
    Team.all.each do |team|

      time_now = Time.now.in_time_zone(team.timezone)

      # Check to see if a report is due today for this team
      if team.recurrence_type = "Weekly" && (team.recurrence_value == time_now.wday)
        send_at_tod = TimeOfDay.parse "#{team.send_request_at.strftime '%H:%M'}"
        now_tod = TimeOfDay.parse "#{time_now.strftime '%H:%M'}"

        expire_time = team.send_request_at + 30.minutes
        expire_tod =  TimeOfDay.parse "#{expire_time.strftime '%H:%M'}"

        if now_tod >= send_at_tod && now_tod <= expire_tod
          # check to se if a report has already been created for today for this team
          status_report = StatusReport.where(team_id: team.id, created_at: time_now.beginning_of_day..time_now.end_of_day)
          if status_report.empty?
            # none yet, create one
            StatusReport.create(team_id: team.id, organization_id: team.organization.id)
          end
        end
      end
    end
  end


  # Finds teams that send requests this day
  #   For each team, checks to see if a report has already been sent for this week
  #     If not
  #       Creates a new StatusReport
  #         Sends an email to every member of the team


end

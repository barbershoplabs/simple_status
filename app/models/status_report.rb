class StatusReport < ActiveRecord::Base
  belongs_to :team
  belongs_to :organization
  has_many :status_summaries, dependent: :destroy
  has_many :users, through: :status_summaries

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
    Team.joins(:organization).where("organizations.status = ?", Organization::STATUSES[:active]).each do |team|

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

  def self.send_status_report_digests
    StatusReport.joins(:organization).where("organizations.status = ? and sent_digest_at is null", Organization::STATUSES[:active]).each do |status_report|
      team = status_report.team
      time_now = Time.now.in_time_zone(team.timezone)

      created_at = status_report.created_at.in_time_zone(team.timezone)
      send_at_date = created_at.beginning_of_day + team.send_digest_days_later.days
      send_at_date_time = send_at_date.change(hour: team.send_digest_at.hour, minute: team.send_digest_at.min)

      if time_now > send_at_date_time
        TeamMailer.status_report_digest_email(status_report).deliver
        status_report.sent_digest_at = Time.now
        status_report.save
      end
    end
  end
end

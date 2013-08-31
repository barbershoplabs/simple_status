class User < ActiveRecord::Base
  has_many :memberships, dependent: :delete_all
  has_many :organizations, through: :memberships
  has_many :team_memberships
  has_many :teams, through: :team_memberships
  has_many :status_summaries
  has_many :status_reports, through: :teams
  before_save :downcase_email

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def downcase_email
    self.email = self.email.downcase
  end

  def password_required?
    new_record? ? super : false
  end
end

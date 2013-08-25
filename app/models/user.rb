class User < ActiveRecord::Base
  has_many :memberships, dependent: :delete_all
  has_many :organizations, through: :memberships
  has_many :team_memberships


  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def password_required?
    new_record? ? super : false
  end
end

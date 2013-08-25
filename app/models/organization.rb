class Organization < ActiveRecord::Base
  belongs_to :plan
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :teams

  accepts_nested_attributes_for :users

  def owner
    memberships.where("role = ?", "owner").first.user
  end
end

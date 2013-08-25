class Organization < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  belongs_to :plan

	accepts_nested_attributes_for :users

  def owner
    memberships.where("role = ?", "owner").first.user
  end
end

class Team < ActiveRecord::Base
  RECURRENCE_TYPES = ["Weekly"]

  belongs_to :organization
  has_many :team_memberships, dependent: :destroy
  has_many :users, through: :team_memberships

  accepts_nested_attributes_for :team_memberships, :reject_if => :all_blank, :allow_destroy => true
end

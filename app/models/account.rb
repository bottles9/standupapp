class Account < ApplicationRecord

  resourcify
  has_many :users
  has_one :subscription
  validates :name, presence: true
  has_many :teams
end

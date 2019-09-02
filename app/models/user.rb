class User < ApplicationRecord

  include Friendlyable
  rolify
  attr_accessor :role
  belongs_to :account, optional: true
  has_many :standups
has_many :team_memberships
has_many :teams, through: :team_memberships
    # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable
end

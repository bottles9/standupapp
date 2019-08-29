class User < ApplicationRecord

  include Friendlyable
  rolify

  belongs_to :account, optional: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable
end

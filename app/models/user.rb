class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :watches

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :role, presence: true
  enum role: { user: 0, admin: 1}
end
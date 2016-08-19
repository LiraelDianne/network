class User < ActiveRecord::Base
  has_many :networks
  has_many :friends, through: :networks
  has_many :invites
  has_many :inviters, through: :invites 

  has_secure_password
  validates :name, :description, presence: true
  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, uniqueness: {case_sensitive: false}, format: {with: email_regex} 
  validates :password, length: {minimum: 8}
end

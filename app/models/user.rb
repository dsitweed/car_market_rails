class User < ApplicationRecord
  has_secure_password

  before_save {email.downcase!}

  validates :name, presence: true, length: {maximum: 255}
  validates :password, presence: true, length: {minimum: 6}
  validates :email, presence: true, length: {maximum: 255},
            format: {with: Settings.regex.email},
            uniqueness: {casesensitive: false}
end

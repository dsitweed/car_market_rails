class User < ApplicationRecord
  has_secure_password

  before_save{email.downcase!}

  validates :name, presence: true, length: {maximum: 255}
  validates :password, presence: true, length: {minimum: 6}
  validates :email, presence: true, length: {maximum: 255},
            format: {with: Settings.regex.email},
            uniqueness: {casesensitive: false}

  # Return the hash digest of the given string
  def self.digest string
    cost = if ActiveModel::SecurePassword.min_cost
      BCrypt::Engine::MIN_COST
    else
      BCrypt::Engine.cost
    end

    BCrypt::Password.create(string, cost)
  end
end

class User < ApplicationRecord
  has_secure_password
  attr_accessor :remember_token, :activation_token, :password_reset_token

  before_save :downcase_email
  before_create :create_activation_digest

  validates :name, presence: true, length: {maximum: 255}
  validates :password, presence: true, length: {minimum: 6}
  validates :email, presence: true, length: {maximum: 255},
            format: {with: Settings.regex.email},
            uniqueness: {casesensitive: false}

  scope :desc, -> {order(created_at: :desc)}

  # Remembers a user in the database for use in persisten sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(self.remember_token))
    remember_digest
  end

  # Returns true if the given token matches the digest.
  def authenticated? attribute, token
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Return a session token to prevent session hijacking.
  # We reuse the remember digest for convenience
  def session_token
    remember_digest || remember
  end

  def is_admin?
    return true if role == 2
    false
  end

  # Activate an account
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def send_activation_email
    UserMailer::account_activation(self).deliver_now
  end

  private

  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end

  # Creates and assigns the activation token and digest
  # execute before creating a new user
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  class << self
    # Return the hash digest of the given string
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end

      BCrypt::Password.create(string, cost:)
    end

    # Return a random token
    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end

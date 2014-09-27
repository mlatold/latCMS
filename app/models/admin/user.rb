class Admin::User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :set_defaults

  validates :email, presence: true,
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  has_secure_password

  def self.random_hash
    Digest::SHA1.hexdigest(SecureRandom.uuid)
  end

  private

    def set_defaults
      self.user_secret = Admin::User.random_hash
    end
end

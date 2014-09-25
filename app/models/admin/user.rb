class Admin::User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :email, presence: true,
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }

end

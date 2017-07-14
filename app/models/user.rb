class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { email.downcase! }
  has_secure_password
  validates :name, presence: true,
                   length: { maximum: 50 }
  validates :email, presence: true,
                    length: { maximum: 254 },
                    format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true,
                    length: { minimum: 6 },
                    allow_nil: true
                    
  def self.digest(password)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(password, cost: cost)
  end
  
  def remember
    self.remember_token = SecureRandom.urlsafe_base64
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  def authenticated?(token)
    return false if token.nil?
    BCrypt::Password.new(remember_digest).is_password?(token)
  end
end

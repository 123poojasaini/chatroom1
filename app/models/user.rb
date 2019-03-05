class User < ApplicationRecord
 before_save :encrypt_password
 before_create :confirmation_token
  
  
 validates :username,:fname,:lname,:email, presence: true
 validates :password, confirmation: true
 validates :password, length: { in: 6..20 }
 validates_presence_of :password, :on => :create
  validates_uniqueness_of :email

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email) 
    if user && user.password_hash == BCrypt::Engine.hash_secret(password,user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  private
    def confirmation_token
      if self.confirm_token.blank?
          self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
    end

  def password_must_be_present
    errors.add(:password, "missing password") unless password.present?
  end
end

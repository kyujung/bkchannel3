require 'digest'
class User < ActiveRecord::Base
  attr_accessor :password
  
  validates :nickname, :uniqueness => true, 
                    :length => { :within => 3..10 },
                    :presence => true
                       
  validates :email, :uniqueness => true, 
                    :length => { :within => 10..50 }, 
                    :format => { :with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }
                    
  validates :password, :confirmation => true,
                       :length => { :within => 4..20 },
                       :presence => true,
                       :if => :password_required?

  has_many :messages, :order => 'created_at DESC'

  before_save :encrypt_new_password

  def self.authenticate(email, password)
    user = find_by_email(email)
    return user #if user && user.authenticated?(password)
  end

  def authenticated?(password)
    self.hashed_password == encrypt(password)
  end

  protected
    def encrypt_new_password
      return if password.blank?
      self.hashed_password = encrypt(password)
    end

    def password_required?
      hashed_password.blank? || password.present?
    end

    def encrypt(string)
      Digest::SHA1.hexdigest(string)
    end
end

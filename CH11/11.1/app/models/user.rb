require 'digest/sha1'
require 'openssl'

# table "users"
#   login, string
#   secured_password, string(40)
#   salt, string(40)

class User < ActiveRecord::Base

  attr_accessor :password
  before_save :secure_password

  def self.authenticate?(login, pass)
    user = find_by_login(login)
    return false unless user
    return user.authenticate?(pass)
  end

  def authenticate?(pass)
    secured_password == self.class.encrypt(pass, salt)
  end

  protected

  def secure_password
    self.salt = generate_salt if new_record?
    self.secured_password = encrypt(password) if password
  end

  def generate_salt
    Digest::SHA1.hexdigest(OpenSSL::Random.random_bytes(128))
  end

  def encrypt(password)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

end

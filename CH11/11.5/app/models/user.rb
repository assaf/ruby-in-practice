require 'digest/sha1'
require 'openssl'

class User < ActiveRecord::Base
  
  before_create :generate_token

  def generate_token
    self.token = Digest::SHA1.hexdigest(OpenSSL::Random.random_bytes(128))
  end
  
end
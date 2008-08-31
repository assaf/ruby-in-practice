require 'digest/sha1'
require 'openssl'

class AddUserToken < ActiveRecord::Migration

  class User < ActiveRecord::Base
  end

  def self.up
    add_column :users, :token, :string, :limit => 40
    User.find(:all).each do |user|
      user.token = Digest::SHA1.hexdigest(OpenSSL::Random.random_bytes(128))
      user.save
    end
  end

  def self.down
    remove_column :users, :token
  end
end 

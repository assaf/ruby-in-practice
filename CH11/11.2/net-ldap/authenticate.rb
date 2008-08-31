require 'net/ldap'

def valid_user?(username, password)
  ldap = initialize_ldap(username, password)
  ldap.bind
end

def initialize_ldap(username, password)
  Net::LDAP.new(:base => 'dc=example,dc=com',
                :host => 'your-ldap-server',
                :auth => {:username => "uid=#{username},cn=users",
                          :password => password,
                          :method => :simple})
end 

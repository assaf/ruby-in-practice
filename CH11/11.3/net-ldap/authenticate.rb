require 'net/ldap'

def valid_user?(username, password)
  ldap = initialize_ldap(username, password)
  ldap.bind
end

def initialize_ldap(username, password)
  Net::LDAP.new(:base => 'dc=example,dc=corp',
                :host => 'exampledomaincontroller',
                :auth => {:username => "#{username}@example.corp",
                          :password => password,
                          :method => :simple})
end 

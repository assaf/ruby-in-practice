require 'activedirectory'

def valid_user?(username, password)
  user = ActiveDirectory::User.find('jdoe')
  user.authenticate(password)
end 
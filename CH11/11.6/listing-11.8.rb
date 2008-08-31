require 'cgi'

class CGI
  def basic_auth_data
    user, pass = '', ''
    header_keys = ['HTTP_AUTHORIZATION', 'X-HTTP_AUTHORIZATION',
                   'X_HTTP_AUTHORIZATION',
                   'REDIRECT_X_HTTP_AUTHORIZATION']
    header_key = header_keys.find{ |key| env_table.has_key?(key) }
    authdata = env_table[header_key].to_s.split if header_key
    if authdata and authdata[0] == 'Basic'
      user, pass = Base64.decode64(authdata[1]).split(':')[0..1] 
    end
    return user, pass
  end
end

# Here's an example usage:

cgi = CGI.new
username, password = cgi.basic_auth_data 

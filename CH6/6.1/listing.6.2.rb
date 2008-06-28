require 'rubygems'
require 'mailfactory'
require 'net/smtp'

ADMINS = ['jeremy@yourco.com', 'assaf@yourco.com']

# Construct our message once since our list of admins 
# and our message is static.
mail = MailFactory.new
mail.text = "The Apache process is down on #{Socket.gethostname}. Please restart it!"
mail.subject = "Apache is down on #{Socket.gethostname}"
mail.from = "Apache Notifier <notifier@yourco.com>"
mail.to = ADMINS.join(',')

# Is the process running?
while (true)
  unless `ps -A`.include?("apache")
    puts "** Process is down"
 
    Net::SMTP.start("my.smtp.com", 25, "my.smtp.com", "user", "password", :plain) do |smtp|
      smtp.send_message mail.to_s, mail.from.first, mail.to
    end
  end
 
  sleep 5
end


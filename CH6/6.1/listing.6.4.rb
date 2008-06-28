require 'net/pop'

AUTHORIZED = ['jeremy@yourco.com', 'assaf@yourco.com']
RESTART = '/etc/init.d/mysql restart'

while true

  Net::POP3.start('pop.yourhost.com', 110, 'cly6ruct1yit2d@yourco.com', 'dbMASTER') do |pop|
 
    puts "received #{pop.mails.length} messages"
      unless pop.mails.empty?
        pop.mails.each do |mail|
          msg = mail.pop
     
          # If the subject has the phrase and they're authorized...
          from = msg[/^From:.*<(.*)>\r\n/, 1]
          if (msg =~ /^Subject:.*Restart MySQL.*/i) && (AUTHORIZED.include?(from))
            # ...then, restart MySQL
            `#{RESTART}`
          end
     
         # Delete the mail message
         mail.delete
      end
    end
  end
 
  # Don't hammer your POP3 server :)
  sleep 30
end

require 'rubygems'
require 'xmpp4r-simple'

AUTHORIZED=['admin@yourco.com', 'admin2@yourco.com']

COMMANDS = {
  'start' => '/etc/init.d/mysql start',
  'stop' => '/etc/init.d/mysql stop',
  'restart' => '/etc/init.d/mysql restart'
}

im = Jabber::Simple.new('user@yourco.com', '%aZ$w0rDd')

puts "Waiting on messages."
while true
  im.received_messages do |message|
    # Build a usable user ID from the message
    from = message.from.node + '@' +
           message.from.domain
 
    # Are they authorized?
    if AUTHORIZED.include?(from)
      puts "Received message from #{message.from}"
 
      if COMMANDS[message.body]
        `#{COMMANDS[message.body]}`
        status = "MySQL told to #{message.body}."
      else
        status = "Invalid command!"
      end
      im.deliver from, status
    end
  end
 
  # Don't want to eat up more CPU than necessary...
  sleep 3
end

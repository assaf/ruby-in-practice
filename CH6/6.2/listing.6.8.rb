require 'rubygems'
require 'xmpp4r-simple'

im = Jabber::Simple.new('you@jabberserver.com', 'p@s$')
im.roster.add('them@jabberserver.com')
im.deliver('them@jabberserver.com', "Hello from Ruby!")

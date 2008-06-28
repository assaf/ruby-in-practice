require 'rubygems'
require 'net/toc'

client = Net::TOC.new('yourbot', 'p@$$w0rd')
client.connect

friend = client.buddy_list.buddy_named('youraimuser')
friend.send_im "Hello, from Ruby."

client.disconnect

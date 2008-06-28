require 'rubygems'
require 'net/toc'

def get_server_information
  <<-TXT
  uptime
  ------
  #{`uptime`}

  disk information
  ----------------
  #{`df -k`}\n
  TXT
end

client = Net::TOC.new("youruser", "pa$zWu2d")

client.on_im do | message, buddy |
  friend = client.buddy_list.buddy_named(buddy.screen_name)
  friend.send_im(get_server_information)
end

client.connect
client.wait                                                


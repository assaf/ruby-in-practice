require 'net/pop'

Net::POP3.start('pop3.myhost.com', 110, 'ruby', 'inpractice') do |pop|
  if pop.mails.empty?
    puts "You don't have any email!"
  else
    puts "#{pop.mails.size} mails available."
  end
end

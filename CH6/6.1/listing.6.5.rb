require 'net/pop'
require 'tmail'
require 'net/smtp'

while true
  Net::POP3.start('mail.yourhost.com', 110, 'tickets@yourco.com', 't1xeTz') do |pop| 
    unless pop.mails.empty?

      # Iterate each mail
      pop.mails.each do |mail|
        # Parse the email we received
        ticket_mail = TMail::Mail.parse(mail.pop)
 
        # Create a new Ticket instance
        new_ticket = Ticket.new
        new_ticket.owner = ticket_mail.from
        new_ticket.subject = ticket_mail.subject
        new_ticket.text = ticket_mail.body
        new_ticket.save
 
        # Create and send the new email
        new_mail = TMail::Mail.new
        new_mail.to = ticket_mail.from
        new_mail.from = 'Jeremy <jeremy@jeremymcanally.com>'
        new_mail.subject = "Ticket Created! :: #{ticket_mail.subject}"
        new_mail.date = Time.now
        new_mail.mime_version = '1.0'
        new_mail.set_content_type 'text', 'plain'
        new_mail.body = "A new ticket has been created for you.\n===========\n\n#{ticket_mail.body}\n\nThanks!"
 
        Net::SMTP.start('my.smtp.com', 25, 'my.smtp.com', 'user', 'password', :plain) do |smtp|
          smtp.send_message new_mail.encoded, new_mail.from, new_mail.to
        end
 
        # Delete the received mail message
        mail.delete
      end

    end
  end

  sleep 30
end

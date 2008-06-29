require 'process_accounts'

WMQ::QueueManager.connect(wmq_config) do |qmgr|
  message = WMQ::Message.new
  message.data = <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<account>
  <first-name>John</first-name>
  <last-name>Smith</last-name>
  <company>ACME Messaging</company>
  <email>john@example.com</email>
  <application>wmq-rails.example.com</application>
</account>
  XML
  qmgr.put :q_name=>'ACCOUNTS.CREATED', :message=>message
end

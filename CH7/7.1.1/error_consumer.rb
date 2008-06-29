require 'rubygems'
require 'rexml/document'
require 'stomp'

client = Stomp::Client.new

client.subscribe('/queue/errors') do |message|
  xml = REXML::Document.new(message.body)
  
  puts "Error: #{xml.elements['error/type'].text}"
  puts xml.elements['error/message'].text
  puts xml.elements['error/backtrace'].text
  puts
end

client.join

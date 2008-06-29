require 'rubygems'
require 'stomp'
require 'builder'

class ErrorReporter
  def self.report!(error_object, queue='/queue/errors')
    reporter = Stomp::Client.new
    reporter.send queue, generate_xml(error_object)
  end
  
  private
  def self.generate_xml(error_object)
    payload = ""
    
    builder = Builder::XmlMarkup.new(:target => payload)
    builder.instruct!
    
    builder.error do |error|
      error.type error_object.class.to_s
      error.message error_object.message
      error.backtrace error_object.backtrace.join("\n")
    end
    
    payload
  end
end

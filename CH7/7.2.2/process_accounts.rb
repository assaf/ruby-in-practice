require 'rubygems'
require 'wmq'
require 'active_record'

WMQ_ENV = ENV['WMQ_ENV']

# Set up logging and configure the database connection.
LOGGER = Logger.new(STDOUT)
ActiveRecord::Base.logger = LOGGER
database = YAML.load(File.read('config/database.yml'))[WMQ_ENV].symbolize_keys
ActiveRecord::Base.establish_connection database

# Define the Lead class.
class Lead < ActiveRecord::Base
end

# Read the WMQ configuration and open a connection.
wmq_config = YAML.load(File.read('config/wmq.yml'))[WMQ_ENV].symbolize_keys
WMQ::QueueManager.connect(wmq_config) do |qmgr|
  qmgr.open_queue(:q_name=>'ACCOUNTS.CREATED', :mode=>:input) do |queue|
    queue.each(:sync=>true) do |message|
      begin
        # Parse the document, transform from XML to attributes.
        xml = REXML::Document.new(message.data)
        transform = { :first_name=>'first-name',
                      :last_name=>'last-name',
                      :company=>'company',
                      :email=>'email',
                      :lead_source=>'application' }
        attributes = transform.inject({}) { |hash, (target, source)|
          nodes = xml.get_text("/account/#{source}")
          hash.update(target=>nodes.to_s)
        }
        # Create a new lead.
        lead = Lead.create!(attributes)                              #F
        LOGGER.debug "Created new lead #{lead.id}"
      rescue Exception=>ex
        LOGGER.error ex.message
        LOGGER.error ex.backtrace
        # Raise exception, WMQ keeps message in queue.
        raise
      end
    end
  end
end


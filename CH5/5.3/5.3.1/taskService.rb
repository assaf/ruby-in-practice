#!/usr/bin/env ruby
require 'taskServiceServant.rb'
require 'taskServiceMappingRegistry.rb'
require 'soap/rpc/standaloneServer'

module TaskManager

  class TaskManagement
    Methods = [
      [ "http://example.com/taskManager/createTask",
        "createTask",
        [ ["in", "task", ["::SOAP::SOAPElement", "http://example.com/taskManager", "createTask"]],
          ["out", "task", ["::SOAP::SOAPElement", "http://example.com/taskManager", "createTaskResponse"]] ],
        { :request_style =>  :document, :request_use =>  :literal,
          :response_style => :document, :response_use => :literal,
          :faults => {} }
      ]
    ]
  end

  class TaskManagementApp < ::SOAP::RPC::StandaloneServer
    def initialize(*arg)
      super(*arg)
      servant = TaskManager::TaskManagement.new
      TaskManager::TaskManagement::Methods.each do |definitions|
        opt = definitions.last
        if opt[:request_style] == :document
          @router.add_document_operation(servant, *definitions)
        else
          @router.add_rpc_operation(servant, *definitions)
        end
      end
      self.mapping_registry = TaskServiceMappingRegistry::EncodedRegistry
      self.literal_mapping_registry = TaskServiceMappingRegistry::LiteralRegistry
    end
  end

end

if $0 == __FILE__
  # Change listen port.
  server = TaskManager::TaskManagementApp.new('app', nil, '0.0.0.0', 10080)
  trap(:INT) do
    server.shutdown
  end
  server.start
end

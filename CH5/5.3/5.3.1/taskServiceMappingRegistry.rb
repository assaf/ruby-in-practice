require 'taskService.rb'
require 'soap/mapping'

module TaskManager
  module TaskServiceMappingRegistry

    EncodedRegistry = ::SOAP::Mapping::EncodedRegistry.new
    LiteralRegistry = ::SOAP::Mapping::LiteralRegistry.new
    NsTaskManager = "http://example.com/taskManager"

    LiteralRegistry.register(
      :class => TaskManager::CreateTask,
      :schema_name => XSD::QName.new(NsTaskManager, "createTask"),
      :schema_element => [
        ["title", ["SOAP::SOAPString", XSD::QName.new(nil, "title")]],
        ["priority", ["SOAP::SOAPInt", XSD::QName.new(nil, "priority")], [0, 1]]
      ]
    )

    LiteralRegistry.register(
      :class => TaskManager::CreateTaskResponse,
      :schema_name => XSD::QName.new(NsTaskManager, "createTaskResponse"),
      :schema_element => [
        ["id", ["SOAP::SOAPString", XSD::QName.new(nil, "id")]]
      ]
    )

  end
end

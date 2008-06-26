require 'xsd/qname'

module TaskManager

  # {http://example.com/taskManager}createTask
  #   title - SOAP::SOAPString
  #   priority - SOAP::SOAPInt
  class CreateTask
    attr_accessor :title
    attr_accessor :priority

    def initialize(title = nil, priority = nil)
      @title = title
      @priority = priority
    end
  end

  # {http://example.com/taskManager}createTaskResponse
  #   id - SOAP::SOAPString
  class CreateTaskResponse
    attr_accessor :id

    def initialize(id = nil)
      @id = id
    end
  end

end

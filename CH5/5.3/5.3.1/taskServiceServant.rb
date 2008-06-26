require 'taskService'
require 'active_record'

class Task < ActiveRecord::Base
end


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
  class CreateTaskResponse
    attr_accessor :id
    
    def initialize(id)
      @id = id
    end
  end

  class TaskManagement
    # SYNOPSIS
    #   createTask(task)
    #
    # ARGS
    #   task            CreateTask - {http://example.com/taskManager}createTask
    #
    # RETURNS
    #   task            CreateTaskResponse - {http://example.com/taskManager}createTaskResponse
    #
    def createTask(request)
      task = Task.create(:title=>request.title, :priority=>request.priority)
      puts "Created new task with id #{task.id}"
      return CreateTaskResponse.new(task.id)
    end
  end

end

#!/usr/bin/env ruby
require 'taskServiceDriver.rb'

module TaskManager

  endpoint_url = ARGV.shift
  obj = TaskManagement.new(endpoint_url)

  # run ruby with -d to see SOAP wiredumps.
  obj.wiredump_dev = STDERR if $DEBUG

  # SYNOPSIS
  #   createTask(task)
  #
  # ARGS
  #   task            CreateTask - {http://example.com/taskManager}createTask
  #
  # RETURNS
  #   task            CreateTaskResponse - {http://example.com/taskManager}createTaskResponse
  #
  task = nil
  puts obj.createTask(task)

end

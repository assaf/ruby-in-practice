require 'rubygems'
require 'soap/driver'
require 'taskServiceDriver'

driver = TaskManager::TaskManagement.new
task = TaskManager::CreateTask.new('Learn SOAP4R', 1)
task_response = driver.createTask(task)
puts task_response.inspect
puts "Created task #{task_response.id}"

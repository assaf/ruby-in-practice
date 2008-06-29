$KCODE = 'UTF-8'
require 'rubygems'
require 'soap/driver'
require 'taskService'

puts 'Creating server ...'
ActiveRecord::Base.establish_connection(YAML.load(File.read('database.yml')))
db = ActiveRecord::Base.connection
unless db.table_exists?('task')
  db.create_table 'tasks' do |table|
    table.column 'title', :string
    table.column 'priority', :integer
  end
end

server = TaskManager::TaskManagementApp.new 'TaskManager', 'http://example.com/taskManager', '0.0.0.0', 8080
trap(:INT) { server.shutdown }
puts 'Starting server'
server.start

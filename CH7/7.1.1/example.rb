require 'error_reporter'

puts "Generating error ..."
no_such_method rescue ErrorReporter.report!($!)

puts "Consuming error from queue"
require 'error_consumer'

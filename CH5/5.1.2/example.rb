require 'rubygems'
require 'send_order'
require 'mongrel'

class MockService < Mongrel::HttpHandler

  def self.start(port = nil)
    puts "Starting Mongrel on port #{port}"
    mongrel = Mongrel::HttpServer.new('0.0.0.0', port)
    mongrel.register '/', new
    mongrel.run
  end

  def initialize()
  end

  def process(request, response)
    return response.status = 404 unless request.params['PATH_INFO'] == '/create'
    return response.status = 405 unless request.params['REQUEST_METHOD'] == 'POST'
    xml = request.body.read
    puts "Received order:"
    puts xml
    id = rand(1000)  # Fake new order ID
    uri = URI::HTTP.build(:host=>request.params['SERVER_NAME'], :port=>request.params['SERVER_PORT'], :path=>"/orders/#{id}")
    response.start 201 do |head, out|
      head['Location'] = uri.to_s
      out.print xml
    end
  end

end

port = ARGV.first || 3000
puts "Starting mock service"
MockService.start(port)

order = { 'item'=>[ { 'sku'=>'123', 'quantity'=>1 }, { 'sku'=>'456', 'quantity'=>2 } ] }
url = send_order("http://localhost:#{port}/create", order)
puts "Our new order at: #{url}" if url

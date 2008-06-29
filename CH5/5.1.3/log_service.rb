require 'rubygems'
require 'mongrel'
require 'zip/zip'

class LogService < Mongrel::HttpHandler

  def initialize(path)
    @path = path
  end

  def process(request, response)
    return response.status = 405 unless request.params['REQUEST_METHOD'] == 'GET'
    case request.params['PATH_INFO']
    when /^\/(\d{4}-\d{2}-\d{2})$/
      package $1, response
    when '/last'
      package (Date.today - 1).to_s, response
    else
      response.start 404 do |head, out|
        head['Content-Type'] = 'text/html'
        script = request.params['SCRIPT_NAME']
        out.write "<h1>Request URL should be #{script}/last"\
                  " or #{script}/[yyyy]-[mm]-[dd]</h1>"
       end
    end
  end

private

  def package(date, response)
    zip_filename = "logs-#{date}.zip"
    tmp_file = Tempfile.open(zip_filename)
    begin
      Zip::ZipOutputStream.open(tmp_file.path) do |zip|
        Dir.glob("#{@path}/*-#{date}.log").each do |filename|
          zip.put_next_entry File.basename(filename)
          zip << File.read(filename)
        end
      end
      response.start 200 do |head, out|
        head['Content-Type'] = 'application/zip'
        head['Content-Length'] = File.size(tmp_file.path)
        head['Content-Disposition'] = %{attachment; filename="#{zip_filename}"}
        while buffer = tmp_file.read(4096)
          out.write buffer
        end
      end
    ensure
      tmp_file.close!
    end
  end

end

if __FILE__ == $0
  unless path = ARGV[0]
    puts "Usage:"
    puts " ruby log_service.rb <log_dir> [<port>]"
    exit
  end
  port = ARGV[1] || 3000
  service = LogService.new(path)
  puts "Starting Mongrel on port #{port}, serving log files from '#{path}'"
  mongrel = Mongrel::HttpServer.new('0.0.0.0', port)
  mongrel.register '/logs', service
  mongrel.run.join
end

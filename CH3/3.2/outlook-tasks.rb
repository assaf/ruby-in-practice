require 'win32ole'

outlook = WIN32OLE.new('Outlook.Application')

Dir.glob('**/*.rb').each do |file_name|
  lines = File.readlines(file_name)
  lines.each_with_index do |line, line_no|
    match = line.match(/#\s*(TODO|FIXME):?\s*(.*)\s*$/)
    if match
      task = outlook.CreateItem(3)
      task.Subject = "%s: %s" % match.captures
      details = []
      details << "%s, line %d:\n" % [File.join(Dir.pwd, file_name), line_no + 1]
      selection = [line_no - 5, 0].max .. [line_no + 5, lines.size].min
      details.push selection.map { |i| "%5d: %s" % [i + 1, lines[i]] }
      task.Body = details.join
      task.Save
    end
  end
end

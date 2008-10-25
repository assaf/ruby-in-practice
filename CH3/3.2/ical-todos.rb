require 'rubygems'
require 'appscript'

ical = Appscript.app('iCal')
cal = ical.calendars['Work'].get
fail "No work calendar!" unless cal
Dir.glob('**/*.rb').each do |file_name|
  lines = File.readlines(file_name)
  lines.each_with_index do |line, line_no|
    match = line.match(/#\s*(TODO|FIXME):?\s*(.*)\s*$/)
    if match
      summary = "%s: %s" % match.captures
      url = 'file://' + File.join(Dir.pwd, file_name)
      details = []
      details << "%s, line %d:\n" % [File.join(Dir.pwd, file_name), line_no + 1]
      selection = [line_no - 5, 0].max .. [line_no + 5, lines.size].min
      details.push selection.map { |i| "%5d: %s" % [i + 1, lines[i]] }
      ical.make :new=>:todo, :at=>cal.end,
        :with_properties=>{ :summary=>summary, :description=>details.join, :url=>url }
    end
  end
end
 

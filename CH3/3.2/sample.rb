def find(what)
  # TODO: Add other things we can find
  case what
  when 'Waldo'
    puts "Seriously? You need help finding Waldo???"
  else
    puts "Don't know how to search for #{what.inspect}"
  end
end
  
# FIXME: This fails if run with waldo, WALDO, etc.
find(ARGV.first)
require 'process_checker'
require 'test/unit'

class TestProcessChecker < Test::Unit::TestCase
  def setup
    @my_checker = ProcessChecker.new

    output = <<PS
PID  TT  STAT      TIME COMMAND
  1  ?? S<s    0:06.84 /sbin/launchd
 21  ?? Ss     0:13.90 /sbin/dynamic_pager -F /private/var/vm/swapfile
 25  ?? Ss     0:05.37 kextd
 35  p1  S+     0:06.21 ruby script/server
PS

    @my_checker.instance_variable_set('@ps_output', output)
  end
    
  def test_initialized
    assert @my_checker.instance_variables.include?('@ps_output')
  end
  
  def test_rails_server
    assert @my_checker.rails_server?
  end
end

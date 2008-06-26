require 'process_checker'
require 'test/unit'

class TestProcessChecker < Test::Unit::TestCase
  def test_initialize
    my_checker = ProcessChecker.new

    assert my_checker.instance_variables.include?('@ps_output')
  end
end

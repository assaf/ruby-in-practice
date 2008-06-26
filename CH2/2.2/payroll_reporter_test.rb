require 'test/unit'
require 'payroll_reporter'

class ReporterTest < Test::Unit::TestCase

  def setup
    @my_reporter = PayrollReporter.new('test.xml')
  end

  def test_department
    assert_equal nil, @my_reporter.department(1234)
    assert_equal nil, @my_reporter.department("Development")
    expected = {"Andrea Lantz"=> 
                 {"week"=> [{"id"=>"1", "content"=>"40"}, 
                 {"id"=>"2", "content"=>"41"}, 
                 {"id"=>"3", "content"=>"45"}, 
                 {"id"=>"4", "content"=>"39"}]}}
    assert_equal expected, @my_reporter.department("IT")
  end

  def test_employee
    assert_equal nil, @my_reporter.employee(234323)
    assert_equal nil, @my_reporter.employee("Mr. Mustache")
    expected = {"week"=> [
                 {"id"=>"1", "content"=>"40"}, 
                 {"id"=>"2", "content"=>"41"}, 
                 {"id"=>"3", "content"=>"45"}, 
                 {"id"=>"4", "content"=>"39"}]}
    assert_equal expected, @my_reporter.employee("Andrea Lantz")
  end

  def test_get_hours_for
    assert_equal nil, @my_reporter.get_hours_for("Miguel de Jesus")
    assert_equal 165, @my_reporter.get_hours_for("Andrea Lantz")
  end

end

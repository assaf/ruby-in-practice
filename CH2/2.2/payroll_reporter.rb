require 'rubygems'
require 'xmlsimple'

class PayrollReporter

  def initialize(report_path = 'foo.xml')
    @report = XmlSimple.xml_in(report_path, { 'KeyAttr' => 'name' })
  end

  def department(name)
    if @report['department'].keys.include?(name)
      @report['department'][name]['employee']
    end
  end

  def employee(name)
    my_person = nil
    @report['department'].keys.each do |dept|
      if @report['department'][dept]['employee'].keys.include?(name.to_s)
        my_person = @report['department'][dept]['employee'][name.to_s]
      end
    end

    return my_person
  end

  def get_hours_for(name)
    my_employee = employee(name)
    return nil if my_employee == nil

    total_hours = 0
    my_employee['week'].each do |week|
      total_hours += week['content'].to_i
    end

    total_hours
  end

end

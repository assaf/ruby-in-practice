module Test::Unit::WMQTest

  # Read the WMQ configuration for this environment.
  def wmq_config
    @wmq_config ||= YAML.load(File.read("#{RAILS_ROOT}config/wmq.yml"))[RAILS_ENV].symbolize_keys
  end

  # Retrieve last message from the named queue, assert that it exists
  # and yield it to the block to make more assertions.
  def wmq_check_message(q_name)
    WMQ::QueueManager.connect(wmq_config) do |qmgr|
      qmgr.open_queue(:q_name=>q_name, :mode=>:input) do |queue|
        message = WMQ::Message.new
        assert queue.get(:message=>message)
        yield message if block_given?
      end
    end
  end

  # Empty queues at the end of the test.
  def wmq_empty_queues(*q_names)
    WMQ::QueueManager.connect(wmq_config) do |qmgr|
      q_names.each do |q_name|
        qmgr.open_queue(:q_name=>q_name, :mode=>:input) do |queue|
          queue.each { |message| }
        end
      end
    end
  end

end

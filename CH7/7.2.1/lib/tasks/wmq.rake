require 'wmq'

namespace :wmq do
  desc 'Creates WebSphere MQ queues on development and test environments'
  task :setup=>:environment do
    wmq_configs = YAML.load(File.read(File.expand_path('config/wmq.yml', RAILS_ROOT)))
    ['development', 'test'].each do |environment|
      config = wmq_configs[environment].symbolize_keys
      puts "Connecting to #{wmq_config[:q_mgr_name]}"
      WMQ::QueueManager.connect(wmq_config) do |qmgr|
        puts "Creating ACCOUNTS.CREATED queue"
        qmgr.mqsc('define qlocal(ACCOUNTS.CREATED) defpsist(no)')
      end
    end
  end
end

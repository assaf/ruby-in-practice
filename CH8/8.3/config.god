GRACE = 10.seconds

[1, 2].each do |number|
  God.watch do |w|
    path = '/releases/daemons'
    w.name = "my-daemon_#{number}"
    %w{ start stop restart }.each do |task|
      w.send("#{task}=", "#{path}/daemon_#{number}_ctl #{task}")
    end
    w.start_grace = GRACE
    w.restart_grace = GRACE
    w.pid_file = "#{path}/logs/daemon_#{number}.pid"
    w.group = 'my-daemons'
    w.interval = 30.seconds
    
    w.behavior(:clean_pid_file)
    
    w.start_if do |start|
      start.condition(:process_running) do |c|
        c.interval = 5.seconds
        c.running = false
        c.notify = 'lead'
      end
    end
    
    w.restart_if do |restart|
      restart.condition(:memory_usage) do |c|
        c.above = 50.megabytes
        c.times = [2, 3]
        c.notify = 'lead'
      end
      
      restart.condition(:cpu_usage) do |c|
        c.above = 30.percent
        c.times = 5
        c.notify = 'lead'
      end
    end
    
    w.lifecycle do |on|
      on.condition(:flapping) do |c|
        c.to_state = [:start, :restart]
        c.times = 5
        c.within = 5.minutes
        c.transition = :unmonitored
        c.retry_in = 10.minutes
        c.retry_times = 5
        c.retry_within = 2.hours
        c.notify = 'developers'
      end
    end
    
  end
end


God::Contacts::Email.message_settings = {
  :from => 'daemon_master@example.com'
}

God::Contacts::Email.server_settings = {
  :address => 'daemons.example.com',
  :port => 25,
  :domain => 'example.com',
  :authentication => :plain,
  :user_name => 'daemon_master',
  :password => 't3hm4n'
}

{ 'lead' => 'lead@example.com',
  'joe'  => 'joesmith@example.com',
  'john' => 'theman@example.com',
  'mark' => 'marky@example.com' }.each do |name, email|
  God.contact(:email) do |c|
    c.name  = name
    c.email = email
    c.group = 'developers'
  end
end

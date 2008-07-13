set :domain,        'rubyinpratice.com'
set :deploy_to,     '/deploy/ruby_in_practice'
set :repository,    'http://svn.rubyinpractice.com'

role :app,          "prod1.#{domain}"
role :app,          "prod2.#{domain}"
role :app,          "prod3.#{domain}"
role :app,          "prod4.#{domain}"

namespace 'daemon' do
  desc "Start daemon"
  remote_task 'start' do
    run "cd #{deploy_to} && daemon_ctl start"
  end

  desc "Stop daemon"
  remote_task 'stop' do
    run "cd #{deploy_to} && daemon_ctl stop"
  end
end

namespace 'vlad' do
  task 'update' => 'daemon:stop'

  task 'start' do
    task('daemon:start').invoke
  end

  task 'deploy' => ['update', 'migrate', 'start']
end


# root = File.expand_path(File.dirname(__FILE__) + '/../')

root = "/home/March/current"
working_directory root

pid "/home/March/shared/tmp/pids/unicorn.pid"

stderr_path "/home/March/current/log/unicorn.stderror.log"
stdout_path "/home/March/current/log/unicorn.stdout.log"

worker_processes 1
timeout 30
preload_app true

listen '/home/March/shared/tmp/sockets/unicorn.March.sock', backlog: 64

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end

# Force the bundler gemfile environment variable to
# reference the capistrano "current" symlink
before_exec do |_|
  ENV['BUNDLE_GEMFILE'] = File.join(root, 'Gemfile')
end
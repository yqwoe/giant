# config valid only for current version of Capistrano

set :application, 'giant'
set :repo_url, 'git@git.coding.net:xiss/Giant.git'
set :user, 'deploy'
set :rvm_ruby_version, '2.4.1'

# use touch tmp/restart.txt to restart passenger
set :passenger_restart_with_touch, true
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/giant'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/secrets.yml'
append :linked_files, 'config/env.yml'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'config/key', 'public/uploads'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 20

after 'deploy:finished', :worker

desc 'start resque worker'
task :worker do
  on roles(:all) do
    execute('QUEUE=* bundle exec rake resque:work RAILS_ENV=production > /dev/null 2 >&1 &');
  end
end

# config valid for current version and patch releases of Capistrano
lock "~> 3.17.0"

set :application, "corada"
set :repo_url, "git@bitbucket.org:coradadevs/corada-pro.git"

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/rails"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, 'config/secrets.yml'
append :linked_files, 'config/database.yml'

# Default value for linked_dirs is []
## Server Files
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets"
## Assets
append :linked_dirs, 'public/assets', "node_modules"
## Storage
append :linked_dirs, "storage"
## Bundler
append :linked_dirs, '.bundle'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

# Customize Migration Role per official recommendations (https://github.com/capistrano/rails#recommendations)
set :migration_role, :db

# Set rvm path to default path for Ubuntu RVM package
set :rvm_custom_path, '/usr/share/rvm'

# Restart rails
task :restart_rails do
  on roles(:web) do
    execute 'sudo /usr/sbin/service rails restart'
  end
end

after "deploy:published", "restart_rails"

# Restart sidekiq
task :restart_sidekiq do
  on roles(:worker) do
    execute 'sudo /usr/sbin/service sidekiq restart'
  end
end

after "deploy:published", "restart_sidekiq"

# Set AWS Credentials for Autoscaling
set :aws_region,     ENV['AWS_REGION']
set :aws_access_key, ENV['CAP_AWS_ACCESS_KEY_ID']
set :aws_secret_key, ENV['CAP_AWS_SECRET_ACCESS_KEY']

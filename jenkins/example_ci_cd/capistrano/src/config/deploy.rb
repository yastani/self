# config valid only for current version of Capistrano
lock "3.7.1"

set :log_level, :debug
set :keep_releases, 5

# Git Repo
set :repo_url, "https://github.com/yastani/mytest.git"
set :scm, :git
set :branch, 'master'
set :pty, true

# AWS
server '10.0.0.1', use_sudo: 'true', roles: %w{web}, ssh_options: {
  user: 'ec2-user',
  port: 22,
  passphrase: 'password',
  keys: %w(~/.ssh/private),
  forward_agent: true,
  auth_methods: %w(publickey)
}
set :deploy_to, '/var/www/html/'
set :shell,  '/bin/bash --login'

set :application, "html"


=begin
namespace :deploy do
  namespace :check do
  	task :directories_for_rsync do
      on release_roles :all do
        execute :mkdir, '-pv', File.join(fetch(:deploy_to), fetch(:rsync_cache))
      end
    end
  end
end

after 'deploy:check:directories', "deploy:check:directories_for_rsync"

namespace :rsync do
  task :set_options do
    set :rsync_options, %w[--recursive --delete --delete-excluded --exclude .git*]
  end
end

namespace :deploy do
  namespace :sample do
    desc 'my capistrano task'
    task :first_task do
      run_locally do
  	    execute "curl http://localhost:8080"
      end
    end
  end
end



task :update do
  run_locally do
  	application = fetch :application
  	if test "[ -d #{application} ]"
  	  execute "cd #{application}; git pull"
  	  end
  	else
  	  execute "git clone #{fetch :repo_url} #{application}"
  	end
  end
end

task :archive => :update do
  run_locally do
  	sbt_output = capture "cd #{fetch :application}; sbt pack-achive"

    # 正規表現にマッチした部分文字列を消去
  	sbt_output_without_escape_sequences = sbt_output.lines.map { |line| line.gsub(/¥e¥[¥d{1,2}m/, '') }.join

  	archive_relative_path = sbt_output_without_escape_sequences.match(/¥[info¥] Generating (?<archive_path>.+¥.tar¥.gz)¥s*$/)[:archive_path]
  	archive_name = archive_relative_path.match(/(?<archive_name>[^¥/]+¥.tar¥.gz)¥s*$/)[:archive_name]
  	archive_absolute_path = File.join(capture("cd #{fetch(:application)}; pwd").chomp, archive_relative_path)

  	info archive_absolute_path
  	info archive_name

  	set :archive_absolute_path, archive_absolute_path
  	set :archive_namem, archive_name
  end
end

task :deploy => :archive do
  archive_path = fetch :archive_absolute_path
  archive_name = fetch :archive_name
  release_path = File.join(fetch(:deploy_to), fetch(:application))

  on roles(:web) do
  	unless test "[ -d #{release_path} ]"
  	  execute "mkdir -p #{release_path}"
  	end

  	upload! archive_path, release_path

  	execute "cd #{release_path}; tar -zxvf #{archive_name}"
  end
end
=end


# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
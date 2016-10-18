set :application, "js-ipsum"
set :gemset, "jsipsum"

set :repo_url, "git@github.com:LunarLogic/js-ipsum.git"
set :deploy_via, :remote_cache
set :copy_exclude, [".git"]

set :user, "lunar"
set :deploy_to, -> { "/home/#{fetch(:user)}/apps/#{fetch(:application)}" }

set :unicorn_rack_env, -> { fetch(:rails_env) }
set :unicorn_config_path, -> { File.join(release_path, "config/unicorn.rb") }
set :unicorn_pid, -> { File.join(current_path, "pids/unicorn.pid") }

set :rails_env, "production"
set :rack_env, -> { fetch(:rails_env) }
set :deploy_env, -> { fetch(:rails_env) }
set :honeybadger_env, -> { fetch(:stage) }
fetch(:default_env).merge!(rails_env: "production", rack_env: "production")
set :ssh_options, { forward_agent: true }

set :rvm_type, :system
set :rvm_ruby_version, -> { "2.3.1@#{fetch(:gemset)}" }
set :bundle_path, -> { File.join(fetch(:rvm_path), "gems/ruby-#{fetch(:rvm_ruby_version)}") }
set :bundle_cmd, -> { File.join(fetch(:bundle_path), "bin/bundle") }

set :bundle_binstubs, -> { File.join(fetch(:bundle_path), "bin") }

set :keep_releases, 5

set :linked_files, %w{config/unicorn.rb}
set :linked_dirs, %w{pids log}

after "deploy:publishing", "unicorn:restart"
after "deploy:finishing",  "deploy:cleanup"

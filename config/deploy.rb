set :scm,         :git
set :application, "rails-vue"
set :repo_url,    "git@github.com:tablexi/rails-vue.git"

# NOTE: We're managing our own binstubs in the repository
set :bundle_binstubs, nil

set :linked_files, fetch(:linked_files, []).concat(
  %w(
    config/database.yml
    config/secrets.yml
    config/eye.yml.erb
  ),
)

set :linked_dirs, fetch(:linked_dirs, []).concat(
  %w(
    log
    tmp/pids
    tmp/cache
    tmp/sockets
    vendor/bundle
    public/system
  ),
)

set :eye_config, "config/eye.yml.erb"
set :eye_env, -> { { rails_env: fetch(:rails_env) } }

set :rollbar_token, ENV["ROLLBAR_ACCESS_TOKEN"]
set :rollbar_env, Proc.new { fetch :rails_env }
set :rollbar_role, Proc.new { :app }

set :deploytag_time_format, "%Y%m%d%H%M%S"

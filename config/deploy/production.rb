server "rails-vue-app01.txihosting.com",
  user: "rails-vue",
  roles: %w(web app db)

set :deploy_to, "/home/rails-vue/[production-domain].com"
set :rails_env, "production"

# Needed to build pg gem, otherwise pg_config isn't found.
set :default_env, path: "/usr/pgsql-9.3/bin:$PATH"
# CIRCLE_SHA1 is the revision of what was just tested by Circle CI.
# When using TeamCity, you should add `REVISION=%build.vcs.number%` in your deployment step.
set :branch, ENV["CIRCLE_SHA1"] || ENV["REVISION"] || ENV["BRANCH_NAME"] ||"master"

# Skylight is only used in production
set :linked_files, fetch(:linked_files, []).push("config/skylight.yml")

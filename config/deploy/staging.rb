server "rails-vue.stage.tablexi.com",
  user: "rails-vue",
  roles: %w(web app db)

set :deploy_to, "/home/rails-vue/rails-vue.stage.tablexi.com"
set :rails_env, "stage"

# Needed to build pg gem, otherwise pg_config isn't found.
set :default_env, path: "/usr/pgsql-9.3/bin:$PATH"
# CIRCLE_SHA1 is the revision of what was just tested by Circle CI.
# When using TeamCity, you should add `REVISION=%build.vcs.number%` in your deployment step.
set :branch, ENV["CIRCLE_SHA1"] || ENV["REVISION"] || ENV["BRANCH_NAME"] ||"develop"
set :no_deploytags, true

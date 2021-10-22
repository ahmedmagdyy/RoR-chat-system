#!/bin/sh

set -e

echo "Environment: $RAILS_ENV"

# install missing gems
bundle check || bundle install --jobs 20 --retry 5

# Remove pre-existing puma/passenger server.pid
rm -f $APP_PATH/tmp/pids/server.pid

# to apply migrations
bundle exec rake db:create
bundle exec rake db:migrate

# increate max for elasticsearch
sysctl -w vm.max_map_count=262144

# run passed commands
bundle exec ${@}
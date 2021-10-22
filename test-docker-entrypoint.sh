#!/bin/sh

set -e

echo "Environment: $RAILS_ENV"

# Check if we need to install new gems
bundle check || bundle install --jobs 20 --retry 5

bundle exec rake db:create
bundle exec rake db:migrate

# Then run any passed command
bundle exec ${@}
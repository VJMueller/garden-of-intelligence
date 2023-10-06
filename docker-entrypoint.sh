#!/bin/sh

# Exit immediately if any command returns a non-zero status code
set -e

#echo "Running db:create"
#bundle exec rake db:create

#echo "Running db:schema:load"
#bundle exec rake db:schema:load

echo "Running db:migrate"
bundle exec rake db:migrate

echo "Running db:seed"
bundle exec rake db:seed

# Start the Rails server
bundle exec rails server -b "0.0.0.0" -p 3000

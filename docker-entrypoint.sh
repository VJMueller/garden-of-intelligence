#!/bin/sh

# Exit immediately if any command returns a non-zero status code
set -e

echo "Running db:migrate"
bundle exec rake db:migrate

echo "Running db:seed"
bundle exec rake db:seed

bundle exec rails server -b "0.0.0.0" -p 3000

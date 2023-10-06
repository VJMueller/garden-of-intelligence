#!/bin/sh

# Check the database connection
if bundle exec rake db:version >/dev/null 2>&1; then
  exit 0  # Database connection is successful
else
  exit 1  # Database connection failed
fi
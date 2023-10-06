#!/bin/sh

# Perform database migrations
rails db:migrate

# Start the Rails server
exec "$@"

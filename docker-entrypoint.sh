#!/bin/sh

# Perform database migrations
rails db:create

# Start the Rails server
exec "$@"

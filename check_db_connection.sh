#!/bin/bash

# Check the database connection
echo "Checking database connection..."

# Get the DATABASE_URL environment variable
DATABASE_URL="$DATABASE_URL"

# Check if the DATABASE_URL is empty or not set
if [ -z "$DATABASE_URL" ]; then
  echo "ERROR: DATABASE_URL is not set. Please provide the database URL."
  exit 1
fi

# Use psql to attempt the database connection
if psql "$DATABASE_URL" -c "SELECT 1;" > /dev/null 2>&1; then
  echo "Database connection successful!"
else
  echo "Database connection failed. Exiting..."
  exit 1
fi
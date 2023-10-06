#!/bin/bash

# Check the database connection
echo "Checking database connection..."

# Extract the DATABASE_URL environment variable
DATABASE_URL="$DATABASE_URL"

# Use psql to attempt the database connection
if psql "$DATABASE_URL" -c "SELECT 1;" > /dev/null 2>&1; then
  echo "Database connection successful!"
else
  echo "Database connection failed. Exiting..."
  exit 1
fi
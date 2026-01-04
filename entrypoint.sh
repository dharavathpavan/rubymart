#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Run migrations if database url exists
if [ -n "$DATABASE_URL" ]; then
  bundle exec rails db:prepare
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"

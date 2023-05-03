#!/bin/bash
set -e

bundle config set --local path 'vendor/bundle'

bundle install -j3

echo n | bundle exec rails init_db:setup

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"

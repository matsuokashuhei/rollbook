#!/bin/sh -eu

if [ $(uname -s) = 'Darwin' ]
then
  alias docker-compose='docker-compose -f docker-compose.yml -f docker-compose-development.yml'
else
  alias docker-compose='docker-compose -f docker-compose.yml -f docker-compose-production.yml'
fi

alias rails='docker-compose run --rm app rails'
alias bundle='docker-compose run --rm app bundle'
alias app='docker-compose run -- rm app'
alias schemaspy='docker run -v "$PWD/schema:/output" --net="host" schemaspy/schemaspy -t pgsql -host localhost:5432 -db app_development -u postgres'

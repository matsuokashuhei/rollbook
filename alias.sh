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
alias webpacker='docker-compose run --rm app rails webpacker'

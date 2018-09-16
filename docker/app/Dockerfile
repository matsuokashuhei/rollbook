FROM ruby:2.3.1
RUN apt-get update -qq && apt-get install -y --no-install-recommends build-essential libpq-dev

RUN mkdir /rollbook
WORKDIR /rollbook
ADD Gemfile /rollbook/Gemfile
ADD Gemfile.lock /rollbook/Gemfile.lock
RUN bundle install --jobs=4 --clean
ADD . /rollbook


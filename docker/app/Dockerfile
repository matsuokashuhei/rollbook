FROM ruby:2.5.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

RUN mkdir /app
WORKDIR /app
ADD rails/Gemfile /app/Gemfile
ADD rails/Gemfile.lock /app/Gemfile.lock
RUN bundle install --jobs=4 --clean
ADD rails /rollbook

COPY docker/app/ipaexg.ttf /usr/share/fonts/
RUN fc-cache -fv


FROM ruby:2.5.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

ENV LANG C.UTF-8

RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install --jobs=4 --clean
ADD . /app

COPY .devcontainer/ipaexg.ttf /usr/share/fonts/
RUN fc-cache -fv

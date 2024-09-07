FROM ruby:3.3.4

RUN apt update -qq && \
    apt install -y build-essential apt-utils default-libmysqlclient-dev

WORKDIR /app

RUN gem install bundler

COPY Gemfile* ./

RUN bundle install

ADD . /app

EXPOSE 3000

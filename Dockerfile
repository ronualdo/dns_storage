FROM ruby:2.7.1-alpine3.11

RUN apk update && \
  apk add --upgrade postgresql postgresql-dev build-base git tzdata && \
  rm -rf /var/cache/apk/* && \
  gem install bundler && \
  gem install rails && \ 
  mkdir /app

WORKDIR /app

COPY Gemfile ./

RUN bundle install --jobs="$(getconf _NPROCESSORS_ONLN)"

COPY . ./

EXPOSE 3000

CMD bundle exec puma -C config/puma.rb

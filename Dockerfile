FROM --platform=linux/x86_64 ruby:2.6.3-alpine

ADD . /app

WORKDIR /app

RUN bundle install

CMD ["bundle", "exec", "ruby", "app.rb"]

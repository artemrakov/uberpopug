FROM ruby:3.0.2

RUN apt-get update \
      && apt-get install -y build-essential libpq-dev libsqlite3-dev

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -

RUN apt-get update && apt-get install -y nodejs
RUN npm install -g npm-check-updates
RUN npm install -g yarn

ENV BUNDLE_PATH /root/code/uberpopug/auth/vendor/bundle
WORKDIR /root/code/uberpopug/auth

FROM ruby:2.6.3-alpine

RUN apk add --update --no-cache bash build-base nodejs sqlite-dev tzdata postgresql-dev yarn git

RUN gem install bundler:2.0.2

WORKDIR /usr/src/app

COPY package.json yarn.lock ./
RUN yarn install --check-files

COPY Gemfile* ./
RUN bundle install

COPY . .

ENV PATH=./bin:$PATH
CMD ["rails", "console"]

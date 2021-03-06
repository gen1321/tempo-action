# Container image that runs your code
FROM ruby:2.7.0-alpine3.10

COPY Gemfile /Gemfile
RUN apk add --no-cache --update build-base \
  linux-headers 

RUN bundle install
# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY action.rb /action.rb
# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

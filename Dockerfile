# Container image that runs your code
FROM ruby:2.7.0-alpine3.10

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY action.rb /action.rb

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/action.rb"]

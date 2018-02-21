FROM ruby:2.5

WORKDIR /usr/src/app
CMD ["/bin/bash", "-c", "bundle && bundle exec lita"]

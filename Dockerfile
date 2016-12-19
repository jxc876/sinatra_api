FROM ruby:onbuild
EXPOSE 9292
ENV REDIS_URL redis://redis:6379/15
CMD rackup --host 0.0.0.0

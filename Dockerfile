FROM ruby:3.1.0-slim-bullseye

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    postgresql-client \
    git \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /cvwo-api
COPY Gemfile /cvwo-api/Gemfile
COPY Gemfile.lock /cvwo-api/Gemfile.lock
RUN bundle install

COPY . /cvwo-api

EXPOSE 3000

CMD ["bash"]
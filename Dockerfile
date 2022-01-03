FROM ubuntu

RUN apt-get update -qq \
&& apt-get install -y --no-install-recommends \ 
build-essential \
nodejs \
git \
libpq-dev \
postgresql-client \
ruby

ADD . /cvwo-api
WORKDIR /cvwo-api

ENV BUNDLER_VERSION=2.2.22
RUN gem update --system 
RUN gem install bundler -v 2.2.22
RUN bundle install

EXPOSE 3000

CMD ["bash"]

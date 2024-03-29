FROM ubuntu:latest
MAINTAINER m.yoshii <m.yoshii@aaa.org>

# Install basic packages
RUN apt-get update
RUN apt-get install -y build-essential wget curl git
RUN apt-get install -y zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get install -y sqlite3 libsqlite3-dev
RUN apt-get clean

# Install ruby-build
RUN git clone https://github.com/sstephenson/ruby-build.git .ruby-build
RUN .ruby-build/install.sh
RUN rm -fr .ruby-build

# Install ruby
RUN ruby-build 2.1.2 /usr/local

# Install bundler
RUN gem update --system
RUN gem install bundler --no-rdoc --no-ri

# Add application
RUN mkdir /app
WORKDIR /app
ADD app/Gemfile /app/Gemfile
RUN bundle install
ADD app /app

EXPOSE 4567

ENTRYPOINT ["bash", "-l", "-c"]


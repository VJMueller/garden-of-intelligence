FROM ruby:3.1.2-slim
RUN apt-get update -qq \
  && apt-get install -y \
  # Needed for certain gems
  build-essential \
  # Needed for postgres gem
  libpq-dev \
  # Others
  nodejs \
  vim-tiny \   
  # The following are used to trim down the size of the image by removing unneeded data
  && apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf \
  /var/lib/apt \
  /var/lib/dpkg \
  /var/lib/cache \
  /var/lib/log
# Changes localtime to Singapore
RUN cp /usr/share/zoneinfo/Asia/Singapore /etc/localtime
RUN mkdir /garden-of-intelligence
WORKDIR /garden-of-intelligence
COPY Gemfile /garden-of-intelligence/Gemfile
COPY Gemfile.lock /garden-of-intelligence/Gemfile.lock
RUN bundle install
ADD . /garden-of-intelligence
CMD bash -c "rm -f tmp/pids/server.pid && rails s -p 3000 -b '0.0.0.0'"
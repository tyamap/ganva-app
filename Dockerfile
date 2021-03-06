FROM ruby:2.7.1
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq &&  \
    apt-get install --no-install-recommends -y nodejs postgresql-client && \
    apt-get install -y yarn && \
    apt-get install -y vim

RUN mkdir /ganva-app
WORKDIR /ganva-app
COPY Gemfile /ganva-app/Gemfile
COPY Gemfile.lock /ganva-app/Gemfile.lock
RUN bundle install
COPY . /ganva-app
RUN mkdir -p var/run
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
# CMD ["bundle exec unicorn -c config/unicorn.rb -p 3000 -E production"]
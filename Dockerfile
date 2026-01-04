FROM ruby:3.2.2-slim

# Install system dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs libsqlite3-dev git curl

# Set working directory
WORKDIR /app

# Ensure lib directory exists to prevent build crashes
RUN mkdir -p /app/lib

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy application code
COPY . .

# Ensure lib directory exists again ensuring it wasn't overwritten
RUN mkdir -p /app/lib

# Precompile assets
RUN bundle exec rake assets:precompile

# Entrypoint
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

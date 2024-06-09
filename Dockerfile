# Use a slim base image of Ruby
ARG RUBY_VERSION=3.3.1
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim AS base

# Set working directory
WORKDIR /rails

# Set production environment variables
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development" \
    LANG=C.UTF-8

# Throw-away build stage
FROM base AS build

# Install dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential bash bash-completion libffi-dev tzdata postgresql nodejs npm yarn git libpq-dev libvips pkg-config && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle config --global frozen 1 && \
    bundle install --without development test && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copy application code
COPY . .

# Precompile bootsnap code
RUN bundle exec bootsnap precompile app/ lib/

# Final stage for app image
FROM base

# Install runtime dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libvips postgresql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy built artifacts from the build stage
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build --chown=rails:rails /rails /rails

# Set a non-root user
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER rails:rails

# Add Rails bin directory to PATH
ENV PATH="/rails/bin:${PATH}"

# Add a health check to ensure the container is healthy
HEALTHCHECK CMD curl --fail http://localhost:3000/ || exit 1

# Set entrypoint script
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Expose port
EXPOSE 3000

# Default command to start the Rails server
CMD ["./bin/rails", "server"]

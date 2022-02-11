FROM ruby:2.7.0-alpine

RUN apk add --update --virtual \
	runtime-deps \
	postgresql-client \
	build-base \
	libxml2-dev \
	libxslt-dev \
	nodejs \
	yarn \
	libffi-dev \
	readline \
	build-base \
	postgresql-dev \
	libc-dev \
	linux-headers \
	readline-dev \
	file \
	git \
	tzdata \
	&& rm -rf /var/cache/apk/*

WORKDIR /app
COPY . /app/

ENV BUNDLE_PATH /gems
RUN yarn -y install --force --verbose
RUN yarn install node-sass
RUN ls /app/node_modules/node-sass/vendor/
RUN bundle config force_ruby_platform true
RUN bundle install



ENTRYPOINT ["bin/rails"]
CMD  ["s", "-b", "0.0.0.0"]

EXPOSE 3000

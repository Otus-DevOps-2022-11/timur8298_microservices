FROM ruby:2.7-alpine

ENV APP_HOME /app
RUN mkdir $APP_HOME

WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/
RUN apk --no-cache --update add --virtual .build-deps build-base \
  && gem install bundler:1.17.3 \
  && bundle install \
  && apk del .build-deps
COPY . $APP_HOME

ENV COMMENT_DATABASE_HOST comment_db
ENV COMMENT_DATABASE comments

CMD ["puma"]

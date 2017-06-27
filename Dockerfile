FROM ruby:2.4.1
MAINTAINER wangqsh@autoxss.com


RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs \
  locales

RUN locale-gen zh_CN.UTF-8
ENV LANG zh_CN.UTF-8
ENV LANGUAGE zh_CN:zh
ENV LC_ALL zh_CN.UTF-8

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundler install --jobs 20 --retry 5

COPY . ./

EXPOSE 3000
ENTRYPOINT ["bundle", "exec"]

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]



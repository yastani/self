FROM ruby:2.2.6

MAINTAINER Yasunari Tani

RUN mkdir /infrataster

ADD ./src /infrataster/

WORKDIR /infrataster

RUN bundle install

ENTRYPOINT [ "rspec" ]

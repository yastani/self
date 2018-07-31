FROM ruby:2.2.6

MAINTAINER Yasunari Tani

RUN mkdir /serverspec

ADD ./src /serverspec/

WORKDIR /serverspec

RUN bundle install

ENTRYPOINT ["rake", "spec"]

FROM ubuntu:16.04

RUN mkdir -p /app
WORKDIR /app

COPY ./files/ /app/

RUN apt-get update \
  && apt-get install -y \
  software-properties-common \
  && apt-key add dev@makerbot.com.gpg.key \
  && apt-add-repository 'http://downloads.makerbot.com/makerware/ubuntu'

RUN apt-get update \
  && apt-get install -y \
  python \
  python-pip \
  python-setuptools \
  python-pkg-resources \
  python3-jsonschema

RUN apt-get install -y \
  mb-pyserial \
  && dpkg -i sliceconfig_new.deb

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y \
  conveyor \
  makerware

RUN mkdir -p /var/run/conveyor \
  && touch /var/run/conveyor/conveyord.socket \
  && chown -R conveyor:conveyor /var/run/conveyor

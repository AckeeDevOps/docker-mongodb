FROM mongo:3.2

MAINTAINER tomas.hejatko@ackee.cz

RUN apt-get update && apt-get install -y curl lsb-release pwgen

COPY ackee-entrypoint.sh /ackee-entrypoint.sh

# Stackdriver

RUN echo "deb http://packages.cloud.google.com/apt google-cloud-monitoring-$(lsb_release -sc) main" > /etc/apt/sources.list.d/google-cloud-monitoring.list
RUN curl --connect-timeout 5 -s -f "https://packages.cloud.google.com/apt/doc/apt-key.gpg" | apt-key add -
RUN apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y -q install stackdriver-agent
RUN rm -rf /var/lib/apt/lists/*

#COPY setup_stackdriver.sh /opt/01-setup-stackdriver.sh

RUN cp /entrypoint.sh /opt/04-mongo-entrypoint.sh && cp /ackee-entrypoint.sh usr/local/bin/docker-entrypoint.sh

FROM alpine:latest

RUN apk update && \
	apk add wget tar

RUN wget https://repo-feed.flightradar24.com/linux_x86_64_binaries/fr24feed_1.0.18-5_amd64.tgz && \
	tar xvfz fr24feed_1.0.18-5_amd64.tgz

FROM debian:stretch

ENV RECEIVER_HOST dump1090-fa
ENV RECEIVER_PORT 30005

RUN apt-get update && \
	apt-get install -y supervisor gettext-base

COPY --from=0 fr24feed_amd64/fr24feed /
COPY start.sh /
RUN chmod +x /fr24feed /start.sh

COPY supervisor /etc/supervisor
COPY fr24feed.ini.tpl /etc

ENTRYPOINT ["/start.sh"]

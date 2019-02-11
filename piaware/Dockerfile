FROM debian:stretch

RUN apt-get update && \
	apt-get install -y build-essential debhelper tcl8.6-dev autoconf python3-dev python3-venv dh-systemd libz-dev git wget

RUN git clone https://github.com/flightaware/piaware_builder.git
WORKDIR piaware_builder
RUN ./sensible-build.sh stretch

WORKDIR package-stretch
RUN dpkg-buildpackage -b

RUN ls -la ..

FROM debian:stretch

ENV RECEIVER_HOST dump1090-fa
ENV RECEIVER_PORT 30005
ENV RECEIVER_MLAT_PORT 30104

COPY --from=0 piaware_builder/piaware_3.6.3_amd64.deb .

RUN apt-get update && \
	apt-get install -y libexpat1 libreadline7 libssl1.1 libtcl8.6 net-tools tclx8.4 tcl8.6 tcllib tcl-tls itcl3 supervisor

RUN dpkg -i piaware_3.6.3_amd64.deb

ADD supervisor /etc/supervisor
WORKDIR /
ADD start.sh .
RUN chmod +x start.sh

ENTRYPOINT ["/start.sh"]


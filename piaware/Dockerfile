FROM debian:buster

RUN apt-get update && \
	apt-get install -y build-essential debhelper tcl8.6-dev autoconf python3-dev python3-venv dh-systemd libz-dev git wget libboost-system-dev libboost-program-options-dev libboost-regex-dev libboost-filesystem-dev  libssl-dev tcl-dev chrpath

RUN git clone https://github.com/flightaware/piaware_builder.git
WORKDIR piaware_builder
RUN ./sensible-build.sh buster

WORKDIR package-buster
RUN dpkg-buildpackage -b

RUN ls -la ..

RUN mv ../piaware_*_amd64.deb ../piaware.deb

WORKDIR /
RUN git clone https://github.com/flightaware/tcltls-rebuild.git
WORKDIR tcltls-rebuild
RUN ls -la
RUN ./prepare-build.sh buster package-buster

WORKDIR package-buster
RUN dpkg-buildpackage -b
RUN ls -la ..

FROM debian:buster

ENV RECEIVER_HOST dump1090-fa
ENV RECEIVER_PORT 30005
ENV RECEIVER_MLAT_PORT 30104

COPY --from=0 piaware_builder/piaware.deb .
COPY --from=0 tcltls-rebuild/tcl-tls_1.7.16-1+fa1_amd64.deb .

RUN apt-get update && \
	apt-get install -y libexpat1 libreadline7 libssl1.1 libtcl8.6 net-tools tclx8.4 tcl8.6 tcllib tcl-tls itcl3 supervisor libboost-filesystem1.67.0 libboost-program-options1.67.0 libboost-regex1.67.0 libboost-system1.67.0 

RUN dpkg -i tcl-tls_1.7.16-1+fa1_amd64.deb
RUN dpkg -i piaware.deb

ADD supervisor /etc/supervisor
WORKDIR /
ADD start.sh .
RUN chmod +x start.sh

ENTRYPOINT ["/start.sh"]


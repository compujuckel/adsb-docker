FROM debian:buster

RUN apt-get update && \
	apt-get install -y git build-essential fakeroot debhelper librtlsdr-dev pkg-config dh-systemd libncurses5-dev libbladerf-dev libhackrf-dev liblimesuite-dev

WORKDIR /

RUN git clone https://github.com/flightaware/dump1090.git
WORKDIR dump1090
RUN ./prepare-build.sh buster package-buster

WORKDIR package-buster
RUN dpkg-buildpackage -b --no-sign
RUN ls -la ..
RUN mv ../dump1090-fa_*_amd64.deb ../dump1090-fa.deb

FROM debian:buster
COPY --from=0 dump1090/dump1090-fa.deb .

RUN apt-get update && \
	apt-get install -y librtlsdr0 libusb-1.0-0 init-system-helpers lighttpd supervisor libbladerf1 libhackrf0 liblimesuite18.06-1 libncurses6
RUN dpkg -i dump1090-fa.deb
RUN mkdir -p /run/dump1090-fa

ADD supervisor /etc/supervisor

EXPOSE 30001 30002 30003 30004 30005 30104 8080

ENTRYPOINT ["supervisord"]
CMD ["-c", "/etc/supervisor/supervisord.conf"]

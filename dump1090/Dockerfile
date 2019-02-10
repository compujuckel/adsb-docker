FROM debian:jessie

RUN apt-get update && \
	apt-get install -y librtlsdr-dev fakeroot dpkg-dev git debhelper libusb-1.0-0-dev pkg-config dh-systemd libncurses5-dev libusb-1.0-0 build-essential cmake libtecla1 libtecla-dev wget doxygen help2man pandoc

RUN git clone --recursive https://github.com/Nuand/bladeRF.git
WORKDIR bladeRF
RUN git checkout tags/2016.06
RUN dpkg-buildpackage -b

WORKDIR /
RUN dpkg -i libbladerf1_2016.06_amd64.deb libbladerf-dev_2016.06_amd64.deb

RUN git clone https://github.com/flightaware/dump1090.git
WORKDIR dump1090
RUN dpkg-buildpackage -b

FROM debian:jessie
COPY --from=0 libbladerf1_2016.06_amd64.deb .
COPY --from=0 dump1090-fa_3.6.3_amd64.deb .

RUN apt-get update && \
	apt-get install -y librtlsdr0 libusb-1.0-0 init-system-helpers lighttpd supervisor
RUN dpkg -i libbladerf1_2016.06_amd64.deb dump1090-fa_3.6.3_amd64.deb
RUN mkdir -p /run/dump1090-fa

ADD supervisor /etc/supervisor

EXPOSE 30001 30002 30003 30004 30005 30104 8080

ENTRYPOINT ["supervisord"]
CMD ["-c", "/etc/supervisor/supervisord.conf"]

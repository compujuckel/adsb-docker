# adsb-docker
**dump1090-fa + piaware + fr24feed with docker-compose.**

Upload ADS-B data from a local rtlsdr receiver to Flightaware and Flightradar24.

## Configuration
Replace `LAT`, `LON`, `FR24_KEY`, `FLIGHTAWARE_USER`, `FLIGHTAWARE_PASSWORD` and `FLIGHTAWARE_FEEDER_ID` in `docker-compose.yml` with their correct values.

**Additionally, you have to blacklist the `dvb_usb_rtl28xxu` module on the host.**  
To do this, put the following lines into `/etc/modprobe.d/blacklist.conf`:
```
blacklist dvb_usb_rtl28xxu
blacklist rtl2832
```

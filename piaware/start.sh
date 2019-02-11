#!/bin/sh

/usr/bin/piaware-config flightaware-user "${FLIGHTAWARE_USER}"
/usr/bin/piaware-config flightaware-password "${FLIGHTAWARE_PASSWORD}"
/usr/bin/piaware-config mlat-results-format "beast,connect,${RECEIVER_HOST}:${RECEIVER_MLAT_PORT} beast,listen,30105 ext_basestation,listen,30106"
/usr/bin/piaware-config receiver-type other
/usr/bin/piaware-config receiver-host "${RECEIVER_HOST}"
/usr/bin/piaware-config receiver-port "${RECEIVER_PORT}"

if [ -n "${FLIGHTAWARE_FEEDER_ID}" ]; then
  /usr/bin/piaware-config feeder-id "${FLIGHTAWARE_FEEDER_ID}"
fi

supervisord -c /etc/supervisor/supervisord.conf

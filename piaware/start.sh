#!/bin/sh

/usr/bin/piaware-config flightaware-user "${FLIGHTAWARE_USER}"
/usr/bin/piaware-config flightaware-password "${FLIGHTAWARE_PASSWORD}"
/usr/bin/piaware-config receiver-type other
/usr/bin/piaware-config receiver-host "${RECEIVER_HOST}"
/usr/bin/piaware-config receiver-port "${RECEIVER_PORT}"

if [ -n "${FLIGHTAWARE_FEEDER_ID}" ]; then
  /usr/bin/piaware-config feeder-id "${FLIGHTAWARE_FEEDER_ID}"
fi

supervisord -c /etc/supervisor/supervisord.conf

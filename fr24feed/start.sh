#!/bin/sh
envsubst < /etc/fr24feed.ini.tpl > /etc/fr24feed.ini
supervisord -c /etc/supervisor/supervisord.conf

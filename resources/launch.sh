#!/bin/bash
DELAY=2

echo "-----------------------"
echo "Setting environment variables in fcrontabs"
/usr/local/bin/ep *.fcrontab
echo "Injecting the following configuration in background (${DELAY}s delay) :"
awk 'FNR==1{print ""}1' *.fcrontab
(
	sleep $DELAY
	awk 'FNR==1{print ""}1' *.fcrontab | fcrontab -n - && echo "Injection successful" || echo "Injection failed"
) &
echo
echo "Launching fcron daemon ..."
exec fcron -f --nosyslog
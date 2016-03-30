#!/bin/bash
DELAY=2

echo "-----------------------"
rm fcrontab_1
echo "Setting environment variables in fcrontabs"
for FCRON_ENV_VAR in $FCRON_ENV_VARS
do
	echo "$FCRON_ENV_VAR=\${$FCRON_ENV_VAR}" >> fcrontab_1
done
echo "!stdout" >> fcrontab_1
for CMD in $FCRON_COMMANDS
do
	echo "\${$CMD}" >> fcrontab_1
done
/usr/local/bin/ep fcrontab_1
echo "Injecting the fcrontab in background (${DELAY}s delay)."
(
	sleep $DELAY
	echo "Injecting ..."
	awk 'FNR==1{print ""}1' fcrontab_1 | fcrontab -n - && echo "Injection successful" || echo "Injection failed"
) &
echo
echo "Launching fcron daemon ..."
exec fcron -f --nosyslog
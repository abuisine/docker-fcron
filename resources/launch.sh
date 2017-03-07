#!/bin/bash
DELAY=2

echo "-----------------------"
rm fcrontab_1 /usr/local/var/spool/root /usr/local/var/spool/root.orig
echo "Storing environment for commands"
set | grep -v -E "BASHOPTS|BASH_VERSINFO|EUID|PPID|SHELLOPTS|UID" > /tmp/environ

echo "!stdout" >> fcrontab_1
echo "SHELL=/usr/local/bin/environ_bash.sh" >> fcrontab_1
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
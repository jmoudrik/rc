#!/bin/sh

LIMIT=30
[ -n "$1" ] && LIMIT=$1

while true ; do
	BAT=$(acpi -bat 2>&1 | sed -n 's/.*Discharging, \([0-9]*\)%,.*/\1/p')

	[ -n "$BAT" ] && {
		date
		echo $BAT
		[ "$BAT" -le $LIMIT ] && trumpeta
	}
	sleep 1
done


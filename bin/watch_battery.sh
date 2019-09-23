#!/bin/sh
FILE=~/.BATTERY_LOG

LIMIT=30
[ -n "$1" ] && LIMIT=$1

BAT_PLAYED=

while true ; do
	BAT=$(acpi -bat 2>&1 | sed -n 's/.*Discharging, \([0-9]*\)%,.*/\1/p')

	[ -n "$BAT" ] && {
	 	date --rfc-3339=sec
		echo $BAT
	} | tee -a "$FILE"

	[ -n "$BAT" -a "$BAT" -le $LIMIT ] && {
		[ -z "$BAT_PLAYED" ] && trumpeta
		BAT_PLAYED="JO"
	}
	sleep 1
done


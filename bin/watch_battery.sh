#!/bin/sh
FILE=~/.BATTERY_LOG

LIMIT=30
[ -n "$1" ] && LIMIT=$1

BAT_PLAYED=

while true ; do
	ACPI=$(acpi -bat 2>&1)
	BAT=$(echo "$ACPI" | sed -n '/^Battery/s/^.*, \([0-9]*\)%.*$/\1/p')
	ADAPT=$(echo "$ACPI" | sed -n 's/.*Adapter.*\(off\|on\)-line.*/\1/p')

	#echo $ACPI
	#echo $BAT
	#echo $ADAPT

	{
		date --rfc-3339=sec
		[ "$ADAPT" = "on" ] && STATE=charging || STATE=discharging

		echo "$BAT $STATE"
	} | tee -a "$FILE"

	[ "$ADAPT" = "off" ] && [ "$BAT" -le $LIMIT ] && {
		[ -z "$BAT_PLAYED" ] && trumpeta
		BAT_PLAYED="JO"
	}
	sleep 1
done


#!/bin/sh

SEZNAM=77.75.76.3
J2M=37.205.9.130
TARGET=j2m.cz


OUT="$(ping -c 1 -w 1 $J2M)"

RETCODE=$?

#echo $RETCODE
#echo $OUT

#echo "$OUT" | sed -n 's/^.*time=\([0-9.]*\ ms\).*$/\1/p'
[ $RETCODE -eq 0 ] && {
	TUN=$(nc -z localhost 10003 && echo 'T ' || echo 'N ')
	echo "$TUN$TARGET "$(echo "$OUT" | sed -n 's/^.*time=\([0-9.]*\ ms\).*$/\1/p')
} || {
    echo "$TARGET N/A"
}


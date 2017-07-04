#!/bin/sh
flag=$(xset -q | sed -n 's/.*LED mask:[[:space:]]*\([0-9]*\)/\1/p;')

if [ "$flag" = "00000002" ] ; then
    echo en
else
    echo cz
fi


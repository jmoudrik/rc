#!/bin/sh

NY=$(TZ=America/New_York date "+%H:%M")
JP=$(TZ=Japan date "+%H:%M")

echo "NY $NY JP $JP"

#!/usr/bin/env bash

iface="$1"
speed=$(cat /proc/net/dev | grep "$iface" | awk '{print $2}')
echo "$speed"

#!/bin/bash

VAR=`sudo service cron status | grep -c "dead"`
echo "VAR = $VAR"
if [ 1 -eq $VAR ] ; then
    echo "1: VAR = $VAR"
elif [ 0 -eq $VAR ] ; then
    echo "0: VAR = $VAR"
fi

A=set
if [ -v A ] ; then
    echo "$A"
fi

B=set_too
if [ -v $B ] ; then
    echo "$B"
fi

if [ -v C ] ; then
    echo "C"
fi

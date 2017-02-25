#!/bin/bash
FILE=$1
TIMEOUT=900
if grep "ClientAliveInterval" $FILE; then
	sed -i '' "s/ClientAliveInterval.*/ClientAliveInterval ${TIMEOUT}/g" $FILE
else
	echo "ClientAliveInterval ${TIMEOUT}" >> $FILE
fi

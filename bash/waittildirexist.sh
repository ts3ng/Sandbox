#!/bin/bash
while [ ! -d ./somedir ]
do
  sleep 2
done
echo "DIR EXISTS"

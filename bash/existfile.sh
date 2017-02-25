#/bin/bash

if [ ! -f ./notexist.txt ]; then
	echo "not exist"
fi

if [ -f ./exist.txt ]; then
	echo "exists"
fi

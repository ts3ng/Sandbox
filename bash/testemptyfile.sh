#/!/bin/bash

if [ ! -s ./emptyfile.txt ]; then
  echo "empty"
else
  echo "not empty $?"
fi

if [ ! -s ./nonemptyfile.txt ]; then
  echo "empty"
else
  echo "not empty $?"
fi

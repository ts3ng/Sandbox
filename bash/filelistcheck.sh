#!/bin/bash
files="./blah ./foo ./bar ./baz"
for i in $files
do
  if [[ -f $i ]]; then
    cat $i
  else
    echo "does not exist"
  fi
done

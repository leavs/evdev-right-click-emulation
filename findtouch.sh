#!/bin/bash
tmp_dir=$(mktemp -d)
pushd $tmp_dir > /dev/null
# Export whole database 
udevadm info --export-db > udevdb.txt
csplit -s udevdb.txt /^$/ {*}

FILES=./xx*
for f in $FILES
do
  if [[ ! -z $(grep ID_INPUT_TOUCHSCREEN=1 $f) ]] && [[ ! -z $(grep " NAME=*" $f) ]]; 
  then
        # Extract touchscreen name
        grep " NAME=*" $f | cut -d "=" -f 2
  fi
done
popd > /dev/null
rm -rf $tmp_dir
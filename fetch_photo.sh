#!/bin/bash
# if file already exist, exit the script
if [ -f "$1" ] exit 0
# separate filename and extension. THIS is NOT FULL PROOF
#ID_NUMBER=`echo "$1" | cut -d'.' -f1`
filename=$(basename "$1")
ID_NUMBER="${filename%.*}"
#echo "Reading config...." >&2
source .webconfig.cfg
# Now grab the photo we care about.
# -O output the result in given file name
# -c: continue if connection stops and restarts; -b: download in the background
# -w: delay of 1 second between requests
wget -O $1 --load-cookies $SESSION_COOKIES \
--user-agent=$useragent \
--limit-rate=200k \
-c -b \
-w 1 \
-p $warwick_photo_url$ID_NUMBER

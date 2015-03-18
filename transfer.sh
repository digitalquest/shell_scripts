#!/bin/sh

rm /home/admin/bin/transfer-script
datestring=`date --date="yesterday" +%Y%m%d`
echo "mget coursebackups/*"$datestring"*" > /home/admin/bin/transfer-script


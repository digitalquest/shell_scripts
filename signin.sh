#!/bin/bash
#echo "Reading config...." >&2
source .webconfig.cfg
formdata='shire=https%3A%2F%2Fphotos.warwick.ac.uk%2Fphotos%2Fshire&providerId=urn%3Aphotos.warwick.ac.uk%3Aphotos%3Aservice&target=https%3A%2F%2Fphotos.warwick.ac.uk%2Fphotos%2Fphoto.jpg%3Fid%3D1490670&userName="$username"&password="$password"'
# Log in with web sign on.  This can be done only once.
wget --save-cookies $SESSION_COOKIES \
     --user-agent=$useragent \
     --post-data $formdata \
     $warwick_websignon_url
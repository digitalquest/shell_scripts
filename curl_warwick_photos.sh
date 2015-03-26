#!/bin/bash
# first request with curl to log in
curl --user-agent "Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)" --trace-ascii websignon.txt --cookie-jar newcookies.txt --data "shire=https%3A%2F%2Fphotos.warwick.ac.uk%2Fphotos%2Fshire&providerId=urn%3Aphotos.warwick.ac.uk%3Aphotos%3Aservice&target=https%3A%2F%2Fphotos.warwick.ac.uk%2Fphotos%2Fphoto.jpg%3Fid%3D1490670&userName=u1374759&password=m1cr0d1g1t4l" https://websignon.warwick.ac.uk/origin/hs

#second request to photos.warwick to get the photo. use coockes from log in request
wget -O 1490670.jpg --load-cookies newcookies.txt \
     --user-agent="Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)" \
     --limit-rate=200k \
     -c -b \
     -p https://photos.warwick.ac.uk/photos/photo.jpg?id=1490670

#
# version with wget
#

# Log in to the server.  This can be done only once.                   
wget --save-cookies wgetcookies.txt \
     --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.3) Gecko/2008092416 Firefox/3.0.3" \
     --post-data 'shire=https%3A%2F%2Fphotos.warwick.ac.uk%2Fphotos%2Fshire&providerId=urn%3Aphotos.warwick.ac.uk%3Aphotos%3Aservice&target=https%3A%2F%2Fphotos.warwick.ac.uk%2Fphotos%2Fphoto.jpg%3Fid%3D1490670&userName=u1374759&password=m1cr0d1g1t4l' \
     https://websignon.warwick.ac.uk/origin/hs

# Now grab the page or pages we care about.
wget -O 1490670.jpg --load-cookies wgetcookies.txt \
     --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.3) Gecko/2008092416 Firefox/3.0.3" \
     --limit-rate=200k \
     -c -b \
     -p https://photos.warwick.ac.uk/photos/photo.jpg?id=1490670

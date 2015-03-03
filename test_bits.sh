#!/bin/bash
# redirect stdout/stderr to a file
exec &> logfile.txt
#timestamp
echo "timestamp... " `date +%R\ `
#read configuration file
#echo "Reading config...." >&2
source .webconfig.cfg
echo "Reading .webconfig.cfg ...." >&2
source .credentials
echo "Reading .credentials ...." >&2
#
echo "users_to_update= $users_to_update"
echo "username= $username"
echo "password= $password"
echo "useragent= $useragent"
echo "warwick_websignon_url= $warwick_websignon_url"
echo "warwick_photo_url= $warwick_photo_url"
echo "SESSION_COOKIES= $SESSION_COOKIES"
echo "NEW_COOKIES= $NEW_COOKIES"
exit 0
#
if [ ! -f "$users_to_update" ]
# file containing idnumbers is nowhere to be found
then
echo "Cannot find users to update"	
# exit script
exit 2             		
fi

echo "file $users_to_update exists"

#file extension
ext=".jpg"
logfile="logfile.log"

function signin {
  echo "Siging in..."
  formdata="shire=https%3A%2F%2Fphotos.warwick.ac.uk%2Fphotos%2Fshire&providerId=urn%3Aphotos.warwick.ac.uk%3Aphotos%3Aservice&target=https%3A%2F%2Fphotos.warwick.ac.uk%2Fphotos%2Fphoto.jpg%3Fid%3D1490670&userName=$username&password=$password"
  echo "formdata= $formdata"
  # Log in with web sign on.  This can be done only once.
  wget --save-cookies $SESSION_COOKIES --keep-session-cookies \
      --user-agent=$useragent \
      --post-data $formdata \
      $warwick_websignon_url
} 

function fetch_photo {
  # if file already exist, exit the script
  if [ -f "$1$ext" ] 
  then
    echo "$1$ext already exists"
    return 1
  fi
  # separate filename and extension. THIS is NOT FULL PROOF
  #ID_NUMBER=`echo "$1" | cut -d'.' -f1`
#  filename=$(basename "$1")
#  ID_NUMBER="${filename%.*}"
  # Now grab the photo we care about.
  # -O output the result in given file name
  # -c: continue if connection stops and restarts; -b: download in the background
  # -w: delay of 1 second between requests
  # -o (small letter) output errors to logfile. NOT THE SAME AS -O (capital letter)
  echo "fetch $1$ext from $warwick_photo_url$1 - cookie file: $SESSION_COOKIES - usergaent: $useragent"
  wget -O $1$ext --load-cookies $SESSION_COOKIES \
  --keep-session-cookies \
  --user-agent=$useragent \
  --limit-rate=200k \
  -c -b \
  -w 1 \
  -p $warwick_photo_url$1
} 

# web sign on
signin
# read file and loop through it
while read -r line || [[ -n $line ]];
do
  fetch_photo $line
  # Waits 5 seconds
  sleep 5
done <$users_to_update

#!/bin/sh

## GitLab push hook update script

# The output of this script is logged by PHP, so any unnecessary output should
# be discarded. To enable logging of any output the cd command produces, make
# the command look like this:
#
#     cd ..
#
MOODLE_DIR=/data/www/html
REPO=origin
BRANCH=MOODLE_26_STABLE
LOGFILE=/data/www/webhook-push.log
#remote repositiry and branch to track
#REMOTE=origin
#BRANCH=MOODLE_26_STABLE

#echo "cd to '$MOODLE_DIR'" >> $LOGFILE
cd $MOODLE_DIR
#pwd >> $LOGFILE
#echo "finished cd to '$MOODLE_DIR'" >> $LOGFILE

# Pulls currently configured upstream branch. To configure the upstream branch,
# use the following command:
#
#     git branch --set-upstream local-branch origin/remote-branch
#
# where:
#   local-branch   the name of your local branch
#   origin         the name of the upstream remote
#   remote-branch  the name of the upstream branch
#
# The remote upstream branch should only be configured once, unless the remote
# name changes
#
#echo "starting git command..." >> $LOGFILE
git pull --tags $REPO $BRANCH
#echo "finished git command..." >> $LOGFILE

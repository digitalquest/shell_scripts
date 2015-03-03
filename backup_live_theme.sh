#!/bin/sh
#
# backs up the theme warickclesan
# from ulcc
#
# define the repo, branch and working directory
REPO=origin
BRANCH=master
WORKING_DIR=$HOME/github/moodle_live_theme_backup
ULCC_DIR=$HOME/ulcc/war2moodle_theme/warwickclean
#
# change to the directory where local git repo is
# then copy files from ulcc
cd $WORKING_DIR
cp -r $ULCC_DIR/* $WORKING_DIR
#
# stage all the files and commit
# then push to the repo on actechlab
git add --all
git commit -m "Backup warwickclean; theme of Moodle live/prod. from ULCC - `date`"
git push -u $REPO $BRANCH
#
# make a copy to my H: drive
HDRIVE=$HOME/myfiles/H_Drive/github
cp -r $WORKING_DIR $HDRIVE 

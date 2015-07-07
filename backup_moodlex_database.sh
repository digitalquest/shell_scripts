#!/bin/bash
#
# backs up moodlex database; pipe to gzip
# 
# gets the database credential
source ~/.backup_credentials
# change to database backup folder
cd /data/www/databasebackups
# name of the file created by mysqldump
filename=moodlex-database.sql
# extension of the file after compression
ext=.gz
# suffix given to a previous backup file
old=.old
# if moodle-database.sql.gz exists, move it to moodle-database-old.sql.gz
[ -f $filename$ext ] && mv $filename$ext $filename$old$ext  
#create database dump then compresses it
mysqldump --password=$dbpass -C -Q --create-options $dbname | gzip -f --best --rsyncable > $filename

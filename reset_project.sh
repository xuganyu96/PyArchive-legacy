#!/bin/bash

# DO NOT RUN IT FROM PyCharm
migration_files=`ls */*/migrations/*.py | grep -v -e '__init__'`
for migration_file in $migration_files
do
  echo $migration_file
  rm $migration_file
done

rm ./anniversary_project/db.sqlite3
rm -r ./anniversary_project/media/archives/*
rm -r ./anniversary_project/media/cache/*
rm -r ./anniversary_project/media/profile_pics/*
rm -r ./anniversary_project/log
mkdir ./anniversary_project/log
touch ./anniversary_project/log/system.log

chmod a+x ./aws_credentials.conf
source ./aws_credentials.conf
cd anniversary_project
python manage.py makemigrations
python manage.py migrate
python manage.py createsuperuser --no-input --email "xuganyu96@gmail.com" --username admin
python manage.py runscript reset_project

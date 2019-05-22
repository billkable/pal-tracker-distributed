#!/bin/bash

### the script parameter is the base use route specification
### ${UNIQUE_IDENTIFIER}.\${DOMAIN}

BASE_ROUTE=$1

## Create PCF databases

cf cs p.mysql db-small tracker-allocations-database
cf cs p.mysql db-small tracker-backlog-database
cf cs p.mysql db-small tracker-registration-database
cf cs p.mysql db-small tracker-timesheets-database

## Create local databases

mysql -uroot < databases/create_databases.sql
./gradlew devMigrate testMigrate
./gradlew clean build

## Cherry pick the pipeline and postman

git cherry-pick pipeline
git cherry-pick postman

## Set up routes

sed -i "s/\${UNIQUE_IDENTIFIER}.\${DOMAIN}/$BASE_ROUTE/g" manifest*.yml

## Setup registration endpoint

sed -i "s/http:\/\/\${REGISTRATION_SERVER_ROUTE}/https:\/\/registration-pal-$BASE_ROUTE/g" manifest*.yml
sed -i "s/{your-initials}.{your-domain}/$BASE_ROUTE/g" scripts/postman/pal-tracker-distributed-pcf.postman_environment.json

## Stage, commit and push user environment changes

git add manifest*.yml scripts/postman/pal-tracker-distributed-pcf.postman_environment.json
git commit -m'set route specifications'

## Push and run the pipeline only after you have created your secrets, and cf database creation is complete!

# git push origin main
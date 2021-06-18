#!/bin/bash

UNIQUE_IDENTIFIER=$1
INTERNAL_DOMAIN=$(cf domains|grep internal|cut -d " " -f 1)

## Add network policies for container to container networking

cf add-network-policy tracker-allocations --destination-app tracker-registration
cf add-network-policy tracker-backlog --destination-app tracker-registration
cf add-network-policy tracker-timesheets --destination-app tracker-registration

## Map internal route for registration server

cf map-route tracker-registration ${INTERNAL_DOMAIN} --hostname=registration-pal-${UNIQUE_IDENTIFIER}

## Reset integration points to use internal route for private traffic

cf set-env tracker-allocations REGISTRATION_SERVER_ENDPOINT http://registration-pal-${UNIQUE_IDENTIFIER}.${INTERNAL_DOMAIN}:8080
cf set-env tracker-backlog REGISTRATION_SERVER_ENDPOINT http://registration-pal-${UNIQUE_IDENTIFIER}.${INTERNAL_DOMAIN}:8080
cf set-env tracker-timesheets REGISTRATION_SERVER_ENDPOINT http://registration-pal-${UNIQUE_IDENTIFIER}.${INTERNAL_DOMAIN}:8080

## Restart apps to pick up internal integration points

cf restart tracker-allocations
cf restart tracker-backlog
cf restart tracker-timesheets

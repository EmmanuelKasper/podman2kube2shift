#!/bin/sh
ROUTE=$(oc get -n hello route -o json | jq '.items[0].spec.host'| sed 's/"//g')
echo $ROUTE

while true; do
	date | tee -a /tmp/curl-$(date +%Y-%m-%d).log
	curl -s http://$ROUTE \
	| tee -a /tmp/curl-$(date +%Y-%m-%d).log
	sleep 2
done

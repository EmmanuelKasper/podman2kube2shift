#!/bin/sh
ROUTE=$(oc get -n hello route -o json | jq '.items[0].spec.host'| sed 's/"//g')
OUTPUT=/tmp/curl-$(date +%Y-%m-%d)-ovn.log

while true; do
	date | tee -a $OUTPUT
	curl -s http://$ROUTE | tee -a $OUTPUT
	sleep 2
done

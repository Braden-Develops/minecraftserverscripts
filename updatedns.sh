#!/bin/bash
#
# This script updates my DNS A record if my IP address has changed.

key="$(cat MYKEY.txt)"                          # Enter your GoDaddy production API key here. I have mine formatted to read a file. https://developer.godaddy.com/getstarted
domain="EXAMPLE.com"                            # Enter your domain name here.
recordType="A"                                  # The record type that will be updated.
name="@"                                        # The name of the record that will be updated.
port="1"                                        # Required in request
ttl="3600"                                      # 1hr TTL
weight="1"                                      # Required in request.
header="Authorization: sso-key $key"            # Formats the authorization header.

# Check current DNS A record IP through GoDaddy API - Stores the reply for later
currentARecord=$(curl -s -X GET -H "$header" "https://api.godaddy.com/v1/domains/$domain/records/$recordType/$name" | grep -oE "([0-9]{1,3}[\.]){3}[0-9]{1,3}")

# Check my current public facing IP
currentPublicIP=$(curl -s ifconfig.me)

# If there is a difference between public and DNS record then update the record.
if [[ "$currentARecord" == "$currentPublicIP" ]]; then
        echo "DNS record is current with IP "$currentPublicIP""
elif [[ "$currentARecord" != "$currentPublicIP" ]]; then
        echo "DNS records is not up to date, updating. . ."
        curl -s -X PUT "https://api.godaddy.com/v1/domains/$domain/records/$recordType/$name" \
                -H "accept: application/json" \
                -H "Content-Type: application/json" \
                -H "$header" \
                -d "[ { \"data\": \"$currentPublicIP\", \"port\": $port, \"priority\": 0, \"protocol\": \"string\", \"service\": \"string\", \"ttl\": $ttl, \"weight\": $weight } ]"
fi

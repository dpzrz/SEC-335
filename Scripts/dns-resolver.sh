#!/bin/bash
#Week3 Script 
# Check if both network prefix and DNS server are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <network_prefix> <dns_server>"
    exit 1
fi

network_prefix=$1   # e.g., 10.0.5
dns_server=$2       # e.g., 10.0.5.22 (DNS server to use)

# Header for output
echo "IP,Hostname"

# Loop through IP addresses from .1 to .254
for i in {1..254}; do
    ip="$network_prefix.$i"
    
    # Perform the reverse DNS lookup using the DNS server
    hostname=$(nslookup $ip $dns_server | grep 'name = ' | awk '{print $4}' | sed 's/\.$//')
    
    # If a hostname is found, the output will be displayed
    if [ ! -z "$hostname" ]; then
        echo "$ip,$hostname"
    fi
done

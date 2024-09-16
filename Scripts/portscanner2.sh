#!/bin/bash
# Week3 Script

# Check if both network prefix and port are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <network_prefix> <port>"
    exit 1
fi

network_prefix=$1   # e.g., 10.0.5
port=$2             # e.g., 53 (TCP port for DNS)

# Header for CSV output
echo "host,port"

# Loop through IP addresses from .1 to .254
for i in {1..254}; do
    host="$network_prefix.$i"
    
    # Timeout to check the port and suppress error messages
    timeout 1 bash -c "echo >/dev/tcp/$host/$port" 2>/dev/null && echo "$host,$port"
done

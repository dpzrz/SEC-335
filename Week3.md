# Week 3 DNS

## Class Activity 3.1 DNS Enumeration

This activity is based around DNS and its usefulness when it comes to penetration testing. Throughout this activity we use `nslookup`,`dig`, and `nmap` to gether information from name servers that we were given.

The first script is a rework of our portscanner. This new script will be able to run scans against 10.0.5.0/24. This specific script will target the TCP port thats associated with DNS. 

The script can be found [here](https://github.com/dpzrz/SEC-335/blob/main/Scripts/portscanner2.sh)

```
for i in {1..254}; do
    host="$network_prefix.$i"
    
    # Timeout to check the port and suppress error messages
    timeout 1 bash -c "echo >/dev/tcp/$host/$port" 2>/dev/null && echo "$host,$port"
done
```
Thisis the main portion of the script, were looping through the given range from 1-254. The variable `$network_prefix` holds our `10.0.5` value.

Our second script is made to accept a network prefix and a specified DNS server and perform a lookup.

```
# Header for output
echo "IP,Hostname"

# Loop through IP addresses from .1 to .254
for i in {1..254}; do
    ip="$network_prefix.$i"

```
This portion of our dns_resolver script is similar to our prevoius one. Its a loop through our netowrk prefix. 

```
hostname=$(nslookup $ip $dns_server | grep 'name = ' | awk '{print $4}' | sed 's/\.$//')
```

This line in the script is the command that runs agaisnt our for loop of IP Addresses. It performs `nslookup` and `grep` the names of the lookup. Our awk statement takes the output of grep and prints out the 4th column. Our `sed` command is used to remove the trailing `.` from the output.

We use nmap one liners to run scans that can proudce an ouptut showing if a port is open and the service tied with that port.



### Reflection



## Assignmnet 3.1 Powershell and DNS

## Assignment 3.2 DNS uses TCP and UDP


## More Information

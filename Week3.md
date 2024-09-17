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



## Assignmnet 3.1 Powershell and DNS

## Assignment 3.2 DNS uses TCP and UDP


## More Information

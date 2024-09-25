# Week 4: Manual Vulnrability Detection

Were given a chance to actually crack credentials from a host on our network. The hostname is cupcake and its info isn't given to us through the assignment. We're tasked with gathering info through our `nmap` commands and use some new process to dig deeper into the hosts information.

Info given about the target :
* hostname: `cupcake`
* IP Address `10.0.5.23`
* Domain `cupcake.shire.org`

The one liner below provides port scanning and OS detection. 

`nmap -sV -A -sT 10.0.5.23`

The breakdown of this command and its flags:

* `-sV` : This flag enables version detection. Nmap attempts to detect the version of the services running on the open ports it finds. This can provide detailed information about what software and versions are running on the target machine.
* `-A` : This flag enables aggressive scanning. It combines multiple options to gather as much information as possible. Specifically, it does:

     * OS detection (detects the target's operating system).
     * Version detection (already covered by -sV).
     * Script scanning (runs default Nmap scripts against the target to detect vulnerabilities, misconfigurations, etc.).
     * Traceroute (finds the network path to the host).
* `-sT` : This flag initiates a TCP connect scan. Instead of using the default SYN scan (which is stealthier), it performs a full TCP connection (3-way handshake) to determine whether a port is open. This method is easier to detect by the target but is reliable because it completes the connection.

After this one liner were given alot of infomrmation from our target host:

|IP	|FQDN	|PORT	|PROTOCOL	|SERVICE	|VERSION|
| -- | -- | -- | -- | -- | -- |
|10.0.5.23|	 | 22	|tcp	|ssh	|OpenSSH 5.3 (protocol 2.0)|
|10.0.5.23|	 | 80	|tcp	|http	|Apache httpd 2.2.15 ((CentOS))|

Running: Linux 2.6.X|3.X

CPE: cpe:/o:linux:linux_kernel:2.6 cpe:/o:linux:linux_kernel:3 

### NmapToCSV Walkthrough



`nmaptocsv -i nmapoutput.txt -d ","  `


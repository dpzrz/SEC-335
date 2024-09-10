# Active Recon


## Activity 2.1: Host Discovery
In this activity we were tasked with sweep through a range of IP's gathering infomration. Using `fping` we created a bash script that could scrub trhougha determined set of IP's and run the command

`fping -a -g 10.0.5.2 10.0.5.50`

We then have to send that output to a txt file for data collection, this is done by utilizing `>`. The uses for this script is to be modified throught this activity and the course. Its going to built off of and recreated to suit different needs.

The next part if this activity involves creating anither bash script that utilizes `nmap`


Nmap (“Network Mapper”) is an open source tool for network exploration and security auditing. It was designed to rapidly scan large networks, although it works fine against single hosts. Nmap uses raw IP packets in novel ways to determine what hosts are available on the network, what services (application name and version) those hosts are offering, what operating systems (and OS versions) they are running, what type of packet filters/firewalls are in use, and dozens of other characteristics. [nmapdocs](https://nmap.org/book/man.html#man-description)


Our next bash script will runn the `nmap -n -vv -sn` command against a range of IPs. These outputs will be redirected to another text file that has been created for this scripts results.

### Reflections
The bash script could have been made with more coustimization and usability. These commands couldve been one-liners but I wanted to try and start creating the scripts when an where I could.



## Lab 2.1 Port Scanner

Were creating a bash script to sweep through a list of hosts and a list of adresses. We need to create these pieces that will be used in our script. We create two files that will house our data `mytargets.txt` and `mytcpports.txt`

The script that is created has to access both tthese files and use the list of adresses and ports and perform a port scan against them. We can do this by utilizing variables and a `for loop` within our bash script. The script can be found [here]()




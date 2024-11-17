# Permission Errors and Exploiting Nancurinir

### Linux - Permission Vulnerabilities

Were tasked with creating a C progmar to grab active effective users. Using code provided we create a c script that accomplishes this. 


```
#include <stdlib.h>
#include <pwd.h>
#include <stdio.h>
#include <unistd.h>
/*
SEC335 Illustrate SUID Programs
* based on: https://stackoverflow.com/questions/8953424/how-to-get-the-
username-in-c-c-in-linux
* Make sure run the following
* sudo chown root:root nameofprogram
* sudo chmod u+s nameofprogram
*/

int main(int argc, char *argv[])
{
  struct passwd *pw;
  uid_t uid;
  uid = geteuid ();
  pw = getpwuid (uid);
if (pw)
  {
    puts (pw->pw_name);
    exit (EXIT_SUCCESS);
  }
else
  {
    puts ("Error");
    exit (EXIT_FAILURE);
  }
}
```

The `stat` command allows the user to see the persmissions values as a total. This can be used to identofiy important traits wihtin files. The /usr/bin/passwd program has the suid bit set which means that the program runs with the owner's permissions (root). When a normal user changes their password the /etc/passwd and /etc/shadow files must be changed.

Searching for suid programs across the Kali system can be done through a one-liner command. 

`find / -perm -4000 2>/dev/null`

* `find /`: Starts searching from the root (/) directory
* `-perm -4000`: Looks for files with the SUID bit set 
* `2>/dev/null:` Redirects permission errors to /dev/null, so they won’t clutter your output

Theres a suid program being hidden in rockky so to retieve it we can SSH into the machine and run a slightly altered one-liner.

`find / -perm -4000 -type f -name 'b*' 2>/dev/null`

* `-perm -4000`: Finds files with the SUID bit set (octal value 4000)
* `-type f`: Restricts the search to regular files
* `-name 'b*'`: Filters for files starting with the letter b
* `2>/dev/null`: Redirects permission errors to /dev/null

To locate a word writable file the one liner has to be modified.

`find / -type f -perm -002 2>/dev/null`

* `-type f`: Limits the search to regular files 
* `-perm -002`: Matches files where the others write bit is set
* `2>/dev/null:` Redirects permission errors to /dev/null

Tracking down a word writable file in Rocky is made challenging becasue theres two dorectories that we've been warned will give false positives, the `/sys` and `/proc` direcotries. So the one-liner will need to account for this.

`find /etc -path /sys -prune -o -path /proc -prune -o -type f -perm -002 -name 's*' 2>/dev/null`

* `-find /etc`: Searches through the etc directory
* `-path /sys -prune`: Excludes the /sys directory from the search.
* `-path /proc -prune`: Excludes the /proc directory from the search.
* `-o`: Logical OR operator.
* `-type f`: Restricts the search to regular files.
* `-perm -002`: Matches files that are world-writable .
* `-name 's*'`: Filters files whose names start with the letter s.
* `2>/dev/null`: Redirects permission errors to /dev/null.

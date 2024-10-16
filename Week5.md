# Password Guessing

In Password Guessing were tasked with using the given infomraiton to crack a http form and ssh sessions. We utilize tools such as `hydra`, `dirb` and `cewl`. We create multiple variations of seprate password lists and implement al methods used fro password guessing we've learned.

In this scinerio the IP `10.0.5.21` hosts a webiste that has bios which we'll be scrapping info from. This is possible through the use of `cewl`

`cewl http://10.0.5.21/bios/insertusername -d 2 > username_wordlist.txt`

Using this scarapper were able to create a wordlist for each users bio page. This wordlist is essential to gathering passwords furhter down the lab. This new wordlist is too large to be used and later on to be mangled so it has to be shortened.

I achieved this through by first doing an automated removal of words from the wordlists. This is achived by using grep and a `stopwords.txt` file and `cewl`.

The `stopwords.txt` is a file that contains all the words that will be deleted when running the command below, it acts as a filter for the new trimmed wordlist.

`grep -vi -f stopwords.txt username_wordlist.txt > username_wordlist_trimmed.txt`

With this command were utilizing `grep` to scan the wordlist and remove those words from our base wordlists and then tranfer those results to a trimmed wordlist.


The second method I used is manually going into each trimmed list and making them even smaller in preperation for running them through `rsmangler`. 

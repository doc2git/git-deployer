# git-deployer
### If reply connot resolve url, check if the /home/doc2git/.ssh/id_rsa.pub content in the authroized_keys of git .ssh, which is in directory on server.
## Usage: 
#### On unix-like shell.
#### In created item directory.
```
 git clone git@github.com:doc2git/git-deployer.git;
 bash git-deployer/deploy.sh;
```
#### Follow the interactive dialogue, according actual addition to finsh:
 - git ini,
 - git remote add/set-url all ... ,
 - git commit ... ,
 - git push all ... ,
 - Of course, you need to answser yes/no . 

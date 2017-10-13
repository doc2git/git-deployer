# This is item configure file.

# Bellow several lines variable must be assign according to the real situation;
# Else, item will not exectue normally.

# Bellow serveal line variable can be modify according to the real situation;
# Else, the default values will be used.


localRepoServerPathParent="/home/myreponsitory";
declare -a gitServers;
gitServerAllPrefixes[0]="git@localhost:/home/myreponsitory";
user=$(whoami);
gitServerAllPrefixes[1]="git@github.com:$user";
gitServerAllPrefixes[2]="git@gitee.com:$user";



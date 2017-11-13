# This is item configure file.

# Bellow several lines variable must be assign according to the real situation;
# Else, item will not exectue normally.

# Bellow serveal line variable can be modify according to the real situation;
# Else, the default values will be used.


localRepoServerPathParent="/home/myrepository";
declare -a gitServerAllPrefixes;
gitServerAllPrefixes[0]="git@localhost:/home/myrepository";
user=$(whoami);
gitServerAllPrefixes[1]="git@github.com:ivuex";
gitServerAllPrefixes[2]="git@gitee.com:ivuex";

# 配置fetchServerPrefix可以实现在没有all远程别名的情况下将config.sh中的fetchServerPrefix设为默认的fetch-url;
# 如果现已有all远程别名,还是改.git/config比较方便(将要设置的默认url放在最前面)，毕竟这种情况不会经常发生。tchSeverPrefix="git@github.com:$user";

# example:
# fetchSeverPrefix=${gitServerAllPrefixes[1]};
fetchSeverPrefix=git@localhost:/home/myrepository;



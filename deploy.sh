#!/bin/bash

# 初始化参数
deployer="git-deployer";
source ./$deployer/config.sh;

# user=$(whoami);
for (( i=0; i <= 2; i++  )); do
  if  [[ ${gitServerAllPrefixes[$i]} =~ git@localhost\.*|git@127.0.0.1\.* ]]; then
    localRepoServerPathPrefix=${gitServerAllPrefixes[$i]};
  fi
  echo This gitServerPrefixes will be mapped: ${gitServerAllPrefixes[$i]};
done
echo Alias 'all' branch will be master, when this script would be complated.


rootDir=$(realpath .);
echo 项目根目录: $rootDir;
repoName=$(basename $rootDir);
echo 正在测试的repo名: $repoName;
localRepoServerPath="$localRepoServerPathParent/$repoName.git"

# 定义函数judgeLatestCmd根据判断上一条命令的执行状态码,将尾随函数的第一个作为消息输出到stdoutput;
function judgeLatestCmd(){
  if [ $? -ne 0 ]; then
    echo $1
    if [[ $2 ]]; then
      $2;
    fi
    exit 1
  fi
}

function addMapIfCreated(){
  while [[ true ]]; do
    read created
    if [[ $created == 'yes' ]]; then
      # git remote set-url all --add $1/$repoName.git;
      gitHandleUrl $1/$repoName.git;
      break;
    elif [[ $created == 'no' ]]; then 
      echo 你应该想准备好空的远程仓库：$1/$repoName.git, 一会儿再来哟!
      exit 0
    fi
  done
}

function gitInitIfNoBranchAll(){
  if [[ -d '.git'  ]]; then
    if [[ $(git remote) && $(git remote | grep all) != 'all'  ]]; then
      echo "当前项目是git初始化过的, 并且其中没有映射　'all'";
      echo 请手动输入git命令完成部署。;
      exit 2
    fi
  elif [[  $(git remote | grep all) =~ all ]]; then
    echo "'all' 分支已经存在".
    continue;
  else
    git init;
  fi
}

function gitHandleUrl(){
  if  [[ $1 =~ git@localhost\.*|git@127.0.0.1\.* ]]; then
    if [[ $(git remote -v | grep $1 ) != $1 ]]; then
      git remote add all $1;
    else
      echo "$1 已经在映射 'all' url队列中了";
    fi
  else
    if [[ $(git remote -v | grep $1 ) != $1 ]]; then
      git remote set-url all --add $1;
    else
      echo "$1 已经在映射 'all'  url队列中了";
    fi
  fi
}

for (( i=0; i <= 2; i++  )); do
  if  [[ ${gitServerAllPrefixes[$i]} =~ git@localhost\.*|git@127.0.0.1\.* ]]; then
    gitInitIfNoBranchAll;
    gitHandleUrl ${gitServerAllPrefixes[$i]}/$repoName.git;
    # git remote add all ${gitServerAllPrefixes[$i]}/$repoName.git;
  else
    echo -n "Is the uninitialized repository ${gitServerAllPrefixes[$i]}/$repoName ready?  [ yes / no ]:  "
    addMapIfCreated ${gitServerAllPrefixes[$i]};	
  fi
done

# exit 154;
 
#githubRepo=git@github.com:doc2git/$repoName.git
#giteeRepo=git@gitee.com:doc2git/$repoName.git
#
#repoClientDir=$1/$repoName
#cd $repoClientDir
#git remote rename origin all
#git remote set-url all --add $githubRepo
#git remote set-url all --add $giteeRepo

git remote -v

# 做一次提交，将所有 remote Repo 初始化;
# sult.txt　文件是确保所有 commit 和　push 与上一个版本不同的盐


# 如果localRepoServerPath不存在,就创建本地git--bare库的;
if [ ! -d $localRepoServerPath ]; then

  su git -c "mkdir $localRepoServerPath"
  judgeLatestCmd '创建repo失败'
#  if [ $? -ne 0 ]; then
#    echo 创建repo失败
#    exit 1
#  fi
  
  sudo sh -c "cd $localRepoServerPath; git init --bare"
  judgeLatestCmd '初始化  repo server  失败'
#  if [ $? -ne 0 ]; then
#    echo 
#    exit 1
#  fi
#  
  sudo sh -c "chown git:git $localRepoServerPath -R"
  judgeLatestCmd '将该repo的所属用户和组修改为 git:git 失败'
#  if [ $? -ne 0 ]; then
#    echo　
#    exit 1
#  fi
fi


function exitIfreadNoNeed(){
  while [[ true ]]; do
    read created
    if [[ $created == 'yes' ]]; then
      git remote set-url all --add $1/$repoName.git;
      break;
    elif [[ $created == 'no' ]]; then
      echo 谢谢你的使用，后会有期！
      exit 0;
    fi
  done
}
echo -n "要提交添加工作区修改，提交提交到暂存区，并推送到到映射　'all'　的所有远程 master 分支吗？  [ yes / no ]:   ";
exitIfreadNoNeed;
#　提交并推送到到映射　\'all\'　的所有远程 master 分支；
echo salt >> salt.txt; git add .; git commit -am 'date +%s%N'; git push all master;

echo -n "要创建并切换到 'gh-pages'　分支，并推送到到映射　'gh-pages'　的所有远程 master 分支吗？  [ yes / no ]:   ";
exitIfreadNoNeed;
#  创建并切换到 \'gh-pages\'　分支; 提交并推送到到映射　\'all\'　的所有远程 \'gh-pages\' 分支；
git branch gh-pages;  git checkout gh-pages;
echo salt >> salt.txt; git add .; git commit -am `date +%s%N`;
git push all gh-pages;
git checkout master;

#!/bin/bash

echo -n "请输入你要跟新的分支名: ";
read inputedBranch

echo -n "要创建并切换到 '${inputedBranch}'　分支，并推送到到映射　'${inputedBranch}'　的所有远程 ${inputedBranch} 分支吗？  [ yes / no ]:   ";
exitIfreadNoNeed;
#  创建并切换到 \'gh-pages\'　分支; 提交并推送到到映射　\'all\'　的所有远程 \'gh-pages\' 分支；
git branch ${inputedBranch};  git checkout ${inputedBranch};
echo salt >> salt.txt; git add .; git commit -am `date +%s%N`;
git push all ${inputedBranch};
git checkout master;

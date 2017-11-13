echo -n "请输入你要跟新或创建的分支名: ";
read inputedBranch;

echo -n "要立即创建或/并切换到 '${inputedBranch}'　分支，并推送到到映射　'${inputedBranch}'　的所有远程 ${inputedBranch} 分支吗？  [ yes / no  ]:   ";
read need
if [[ $need == 'yes' ]]; then
  # do something here.
  echo '开始尝试要创建或/并切换到 '${inputedBranch}'　分支';
elif [[ $need == 'no' ]]; then
  echo 谢谢你的使用，后会有期！
  exit 0;
fi

#  创建并切换到 \'gh-pages\'　分支; 提交并推送到到映射　\'all\'　的所有远程 \'gh-pages\' 分支；
git checkout ${inputedBranch};
if [ $? -ne 0 ]; then
  git branch ${inputedBranch};  git checkout ${inputedBranch};
fi
echo salt >> salt.txt; git add .; git commit -am `date +%s%N`;
git push all ${inputedBranch};

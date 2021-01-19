#!/usr/bin/env bash

##############################作者昵称（必填）##############################
# 使用空格隔开
author_list="shylocks whyour moposmall"

##############################作者脚本地址URL（必填）##############################
# 例如：https://raw.githubusercontent.com/whyour/hundun/master/quanx/jx_nc.js
# 1.从作者库中随意挑选一个脚本地址，每个作者的地址添加一个即可，无须重复添加
# 2.将地址最后的 “脚本名称+后缀” 剪切到下一个变量里（my_scripts_list_xxx）
scripts_base_url_1=https://raw.sevencdn.com/shylocks/Loon/main/
scripts_base_url_2=https://raw.sevencdn.com/whyour/hundun/master/quanx/
scripts_base_url_3=https://raw.sevencdn.com/moposmall/Script/main/Me/

##############################作者脚本名称（必填）##############################
# 将相应作者的脚本填写到以下变量中
my_scripts_list_1="jd_gyec.js jd_mh.js jd_ms.js jd_xxl.js jd_xg.js"
my_scripts_list_2="jx_story.js"
my_scripts_list_3="jx_cfd.js"


cd $ScriptsDir   # 在 git_pull.sh 中已经定义 ScriptsDir 此变量，diy.sh 由 git_pull.sh 调用，因此可以直接使用此变量
index=1

for author in $author_list
do
  echo -e "开始下载 $author 的脚本"
  # 下载my_scripts_list中的每个js文件，重命名增加前缀"作者昵称_"，增加后缀".new"
  eval scripts_list=\$my_scripts_list_${index}
  eval url_list=\$scripts_base_url_${index}
  for js in $scripts_list
  do
    eval url=$url_list$js
    eval name=$author_$js
    wget -q --no-check-certificate $url -O dd_$name.new

    # 如果上一步下载没问题，才去掉后缀".new"，如果上一步下载有问题，就保留之前正常下载的版本
    if [ $? -eq 0 ]; then
      mv -f dd_$name.new dd_$name
      echo -e "更新 $name 完成...\n"
    else
      [ -f dd_$name.new ] && rm -f dd_$name.new
      echo -e "更新 $name 失败，使用上一次正常的版本...\n"
    fi
  done
  index=$[$index+1]
done
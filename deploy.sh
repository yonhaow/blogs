#!/usr/bin/env sh
#
#
#
#                                                    __----~~~~~~~~~~~------___
#                                   .  .   ~~//====......          __--~ ~~
#                   -.            \_|//     |||\\  ~~~~~~::::... /~
#                ___-==_       _-~o~  \/    |||  \\            _/~~-
#        __---~~~.==~||\=_    -_--~/_-~|-   |\\   \\        _/~
#    _-~~     .=~    |  \\-_    '-~7  /-   /  ||    \      /
#  .~       .~       |   \\ -_    /  /-   /   ||      \   /
# /  ____  /         |     \\ ~-_/  /|- _/   .||       \ /
# |~~    ~~|--~~~~--_ \     ~==-/   | \~--===~~        .\
#          '         ~-|      /|    |-~\~~       __--~~
#                      |-~~-_/ |    |   ~\_   _-~            /\
#                           /  \     \__   \/~                \__
#                       _--~ _/ | .-~~____--~-/                  ~~==.
#                      ((->/~   '.|||' -_|    ~~-/ ,              . _||
#                                 -_     ~\      ~~---l__i__i__i--~~_/
#                                 _-~-__   ~)  \--______________--~~
#                               //.-~~~-~_--~- |-------~~~~~~~~
#                                      //.-~~~--\
#                               神龙保佑
#                              代码无BUG!
#
###########################################################################################################
# git 
#
# 使用方法:
#     ./file.sh [命令名] [参数,可选]
#
# cl    查看 git 配置信息
# set   设置 用户名和邮箱, 1:名称, 2:邮箱
# init  初始化 git
#
# 
#
###############################################################################################################

name=$1 #操作名称
param1=$2 # 第1个参数
param2=$3 # 第2个参数
startPath=$(pwd) # 执行路径

echo $name
echo $param1
echo $param2

# 确保脚本抛出遇到的错误
set -e

# 显示执行状态
function showStatus {
  if [ $? -eq 0 ]; then
    echo "执行成功"
  else
    echo "执行失败"
  fi
}

# case进行操作
case $name in
  cl) # 创建文件
    git config -l && showStatus
  ;;
  set) # 配置用户信息
    echo "正在设置git提交的用户名和邮箱地址"
    git config --global user.name $param1
    git config --globaluser.email $param2
    showStatus
  ;;
  init) # 初使化
    echo "正在进行Git初始化"
    git init && showStatus
  ;;
  status) # 修改状态
    echo "正在查询仓库修改状态"
    git status -s && showStatus
  ;;
  build) # 打包文件
    echo "正在打包项目文件"
    npm run build
    cd ./dist
    ls -l
    echo "打包完成"
    cd $startPath && showStatus
  ;;
  git) # 提交修改
    echo "正在执行提交命令"
    npm run build
    git status -s
    git add -A
    git cz
    git push -u origin master && git push -u coding master && showStatus
  ;;
esac

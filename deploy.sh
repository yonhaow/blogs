#!/usr/bin/env sh
#############################################################################################################
#                    
#                       █████▒█    ██  ▄████▄   ██ ▄█▀       ██████╗ ██╗   ██╗ ██████╗
#                     ▓██   ▒ ██  ▓██▒▒██▀ ▀█   ██▄█▒        ██╔══██╗██║   ██║██╔════╝
#                     ▒████ ░▓██  ▒██░▒▓█    ▄ ▓███▄░        ██████╔╝██║   ██║██║  ███╗
#                     ░▓█▒  ░▓▓█  ░██░▒▓▓▄ ▄██▒▓██ █▄        ██╔══██╗██║   ██║██║   ██║
#                     ░▒█░   ▒▒█████▓ ▒ ▓███▀ ░▒██▒ █▄       ██████╔╝╚██████╔╝╚██████╔╝
#                      ▒ ░   ░▒▓▒ ▒ ▒ ░ ░▒ ▒  ░▒ ▒▒ ▓▒       ╚═════╝  ╚═════╝  ╚═════╝
#                      ░     ░░▒░ ░ ░   ░  ▒   ░ ░▒ ▒░
#                      ░ ░    ░░░ ░ ░ ░        ░ ░░ ░
#                               ░     ░ ░      ░  ░
#                    
#############################################################################################################
# git 
#
# 使用方法:
#   ./file.sh [命令名] [参数,可选]
#
# dev                       本地启动项目
# build                     打包项目文件
#
# config                    查看Git配置
# set [username] [email]    设置 用户名和邮箱
# init                      初始化Git
# status                    查看文件修改状态
# branch [name]             创建Git分支
# checkout [name]           切换Git分支
# merge [name]              合并分支到主分支
# push [name]               提交到远程仓库
# upload [name]             打包文件并提交修改到远程仓库
#############################################################################################################

name=$1 #操作名称
param1=$2 # 第1个参数
param2=$3 # 第2个参数
startPath=$(pwd) # 执行路径

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
  # 本地启动项目
  dev)
    echo "正在启动项目"
    npm run dev
  ;;
  # 打包项目文件
  build)
    echo "正在打包项目文件"
    npm run build
    cd ./dist
    ls -l
    echo "打包完成"
    cd $startPath && showStatus
  ;;
  # 查看Git配置
  config)
    echo "正在获取Git配置"
    git config -l && showStatus
  ;;
  # 配置用户信息
  set)
    echo "正在设置git提交的用户名和邮箱地址"
    git config --global user.name $param1
    git config --global user.email $param2
    showStatus
  ;;
  # 初使化Git仓库
  init)
    echo "正在进行Git初始化"
    git init && showStatus
  ;;
  # 查看文件改动
  status)
    echo "正在查询仓库修改状态"
    git status -s && showStatus
  ;;
  # 新建Git分支
  branch)
    echo "正在创建新分支：$param1"
    # git checkout -b $param1
    git branch $param1
    echo "正在切换到 $param1 分支"
    git checkout $param1 && showStatus
  ;;
  # 切换Git分支
  checkout)
    echo "正在切换到 $param1 分支"
    git checkout $param1 && showStatus
  ;;
  merge)
    echo "正在切换到 master 分支"
    git checkout master
    git merge $param1 && showStatus
  ;;
  # 提交修改到远程仓库
  push)
    echo "正在执行提交命令"
    # npm run changelog
    git status -s
    git add -A
    npm run commit
    git push -u origin $param1 && git push -u github $param1 && git push -u coding $param1 && showStatus
  ;;
  # 打包并提交提交修改
  upload)
    echo "正在执行提交命令"
    npm run build
    # npm run changelog
    git status -s
    git add -A
    npm run commit
    git push -u origin $param1 && git push -u github $param1 && git push -u coding $param1 && showStatus
  ;;
esac

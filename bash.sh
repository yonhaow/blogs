#!/usr/bin/env bash
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
# git 简写命令,加入linux,mac别名
#
# 使用方法:
#     ./gsh [命令名] [参数,可选]
#
# set   设置用户名和邮箱, 1:名称, 2:邮箱
# init  设置git 简洁命令
#
# gst:     代码变化状态,git status
# gd:     查看当前代码改动变化, git diff, git diff 分支1 分支2
# gam:    [gam 备注] 代码提交本地仓库: git commit -am "备注"
# gpu:    [gpu 远程分支名] 与远程仓库关联: git push -u origin 分支名
# gp:     [gp]推送到远程仓库: git push
# gl:     [gl]拉取远程仓库代码:git pull
# gb:      [gb 新分支名]创建并切换新分支:git checkout -b 新分支名
# gm:     [gm 分支名]合并分支: git merge 分支名
# gcm:     [gcm 目标分支名]切换分支,并更新,再合并: git checkout 分支名B && git pull && git merge 分支名A
# gsave 保存临时修改文件, git stash save
# gpop  恢复临时修改的文件,git stash pop
# glg    查看git日志.git log
#
#
# 编辑时间: 2019-05-24, 作者: 百里, 小站: sgfoot.com, bbs.sgfoot.com
###############################################################################################################

cate=$1 #操作名称
second=$2 # 第1个参数
third=$3 # 第2个参数

echo $cate
echo $second
echo $third

#默认值
default_name="Yonhaow"
default_email="yonhaow@163.com"

# 定义变量
tmp_file=/tmp/git.branch

# 获取分支名
function git.branch {
  br=`git branch | grep "*"`
  touch /tmp/git.branch
  echo ${br/* /} > $tmp_file
}

# 初使值
function git.init {
    git config --global alias.st status
    git config --global alias.df diff
    git config --global alias.co checkout
    git config --global alias.cb 'checkout -b'
    git config --global alias.ci commit
    git config --global alias.br branch
    git config --global alias.mg  merge
    git config --global alias.save 'stash save'
    git config --global alias.pop 'stash pop'
    git config --global alias.un 'reset HEAD'
    git config --global alias.last 'log -1'
    git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
    git config -l
}

# 显示执行状态
function showStatus {
    if [ $? -eq 0 ];then
        echo "执行成功"
    else
        echo "执行失败"
    fi
}

# 显示最近1次提交详情
function showLast {
    count=$1
    show_count=${count:-1}
    git log -$show_count --stat --graph --oneline --relative-date --abbrev-commit -p --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'
}

# 简洁方式显示日志
function showLog {
    git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
}

#对zsh进行别名新建
function create_zshrc {
    #复制当前脚本 到 /usr/local/sbin里
    gsh_file=/usr/local/sbin/gsh
    basepath=$(cd `dirname $0`; pwd)
    filename=$(basename $0)
    gsh=${basepath}/${filename}

    git_alias=~/.zshrc
    #check
    is=`cat $git_alias |grep "alias gst"`
    if [ -n "$is" ];then
        echo "已经安装过"
        exit 0
    fi

    echo "alias gst='$gsh gst'"     >> $git_alias
    echo "alias gam='$gsh gam'"      >> $git_alias
    echo "alias gd='$gsh gd'"     >> $git_alias
    echo "alias gpu='$gsh gpu'"     >> $git_alias
    echo "alias gp='$gsh gp'"     >> $git_alias
    echo "alias gl='$gsh gl'"     >> $git_alias
    echo "alias gb='$gsh gb'"     >> $git_alias
    echo "alias gm='$gsh gm'"     >> $git_alias
    echo "alias gcm='$gsh gcm'"     >> $git_alias
    echo "alias gsave='$gsh gsave'"     >> $git_alias
    echo "alias gpop='$gsh gpop'"     >> $git_alias
    echo "alias glg='$gsh glg'"     >> $git_alias
    echo "alias gset='$gsh gset'"     >> $git_alias
}
#对.bash_profile进行别名新建
function create_profile {
        #复制当前脚本 到 /usr/local/sbin里
        gsh_file=/usr/local/sbin/gsh
        basepath=$(cd `dirname $0`; pwd)
        filename=$(basename $0)
        gsh=${basepath}/${filename}

        git_alias=~/.bash_profile
    #check
        is=`cat $git_alias |grep "alias gst"`
        if [ -n "$is" ];then
                echo "已经安装过"
                exit 0
        fi

        echo "alias gst='$gsh gst'"      >> $git_alias
    echo "alias gam='$gsh gam'"     >> $git_alias
        echo "alias gd='$gsh gd'"        >> $git_alias
        echo "alias gpu='$gsh gpu'"      >> $git_alias
        echo "alias gp='$gsh gp'"        >> $git_alias
        echo "alias gl='$gsh gl'"        >> $git_alias
        echo "alias gb='$gsh gb'"        >> $git_alias
        echo "alias gm='$gsh gm'"        >> $git_alias
        echo "alias gcm='$gsh gcm'"      >> $git_alias
        echo "alias gsave='$gsh gsave'"  >> $git_alias
        echo "alias gpop='$gsh gpop'"    >> $git_alias
        echo "alias glg='$gsh glg'"      >> $git_alias
        echo "alias gset='$gsh gset'"    >> $git_alias
}

help() {
    if [ "$1" = "h" ];then
        echo $2
        exit 0
    fi
}



# case进行操作
case $cate in
    create) # 创建文件
        if [ $2 -eq 1 ];then
            echo "对bash_profile进行别名新建"
            create_profile && showStatus
        else
            echo "对zshrc进行别名新建"
            create_zshrc && showStatus
        fi
    ;;
    init) #初使化
        echo "正在初使git简洁命令"
        git.init && showStatus
    ;;
    set)
        help $second "正在设置git提交的用户名和邮箱地址"
        echo "正在设置git提交的用户名和邮箱地址"
        git config --global user.name $second
        git config --globaluser.email $third
        showStatus
    ;;
    my)
                help $second "正在设置git提交的用户名和邮箱地址"
                echo "正在设置git提交的用户名和邮箱地址"
                git config user.name $default_name
                git config user.email $default_email
                showStatus
        ;;
    gst) # 查看状态
        git status && echo $?
    ;;
    gf) # 对比变化, 支持版本对比,例 gf 需要对比的分支名(注:绿色字体是添加的代码,红色是删除的代码)
        if [ "$second" = "h" ];then
            echo "对比变化, 支持版本对比,例 gf 需要对比的分支名(注:绿色字体是添加的代码,红色是删除的代码)"
            exit 0
        fi
        if [ -n "$second" ];then
            git.branch
            local_branch=`cat $tmp_file`
            git diff $second $local_branch
        else
            git diff
        fi
    ;;
    gam) # 添加,提交代码到本地
        if [ -z "$second" ];then
            echo "请写上你精彩的备注,如: 这是一代牛逼烘烘的代码!!!, 代号:(nb)"
            exit 0
        fi
        if [ "$second" = "nb" ];then
            second="fix:TODO This is nb code"
        fi
        git add -A && git commit -m "$second" && showLast && showStatus
    ;;
    gpu) # 提交代码远程并关联远程仓库
        git push -u origin $second && showStatus
    ;;
    gp) # 提交代码到远程
        if [ -n "$second" ];then
            git push origin $second && showStatus
        else
            git push && showStatus
        fi
    ;;
    gl) # 拉取代码
        if [ -n "$second" ];then
            git pull origin $second && showStatus
        else
            git pull && showStatus
        fi
    ;;
    gb) # 创建并切换新分支
        git checkout -b $second && showStatus
    ;;
    gm) # 合并代码
        if [ -z "$second" ];then
            git.branch
            current_branch=`cat $tmp_file`
            echo "请填写需要合并的分支名称,eg: 如填写A分支名, Usage: git merge A ,代表A分支合并到$current_branch"
            exit 0
        fi
        git merge $second && showStatus
    ;;
    gcm) # 切换分支,并合并代码
        if [ -z "$second" ];then
            echo "请跟上需要合并的分支名称"
                        exit 0
        fi
        git.branch
        old_branch=`cat $tmp_file`
        git checkout $second && git pull && git merge $old_branch && git push && git checkout $old_branch && showStatus
    ;;
    glg) # 简洁方式查看日志
        showLog
    ;;
    gg) # 查看日志哪些文件被改变
        git log  --graph --stat --color --abbrev-commit --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'
    ;;
    gcode) # 查看日志修改的具体的代码
        git log --stat --graph --oneline --relative-date --abbrev-commit -p --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'
    ;;
    gsave) # 暂存项目修改
        git stash save && showStatus
    ;;
    gpop) # 取出暂存的数据
        git stash pop && showStatus
    ;;
    *)
        echo "Usage $0 {init|set|  gst|gam|gpu|gp|gl|gb|gm|gcm|glg|gg|gcode|gsave|gpop}"
        exit 1
    ;;
esac
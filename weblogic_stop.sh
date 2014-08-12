#!/bin/bash
#此脚本用于重启weblogic
#songyj写于2013年6月18号为第一个版本
if [ -z $1 ];then
  echo "必须输入参数！";exit 1
fi


weblogic_domain_path="${WEBLOGIC_PATH}/user_projects/domains/$1"

if [ ! -d $weblogic_domain_path ];then
 echo "not a directory!";exit 1
fi

#log_path="/logs/$1_$(date +%m%d).log"
#echo "log_path=$log_path"

weblogic_pid=$(lsof $weblogic_domain_path|grep 'java' | awk '{print $2}')

#. ${weblogic_domain_path}/bin/stopWebLogic.sh&


if [ -z $weblogic_pid ];then
  echo "域未启动！"
else
  kill -9 $weblogic_pid && echo "已停止！"
fi






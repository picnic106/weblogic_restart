#!/bin/bash
#此脚本用于重启weblogic
#songyj写于2013年6月18号为第一个版本
#2013年7月3号修改为第二个版本，主要是为了将bea目录修改为从环境变量里取。避免写死。如果以后bea变了，将weblogic环境变量加进去就行。
#环境变量是WEBLOGIC_PATH

if [ -z $1 ];then
  echo "必须输入参数！";exit 1
fi


weblogic_domain_path="${WEBLOGIC_PATH}/user_projects/domains/$1"

if [ ! -d $weblogic_domain_path ];then
 echo "not a directory!";exit 1
fi

log_path="/logs/$1_$(date +%m%d).log"
echo "log_path=$log_path"

weblogic_pid=$(lsof $weblogic_domain_path|grep 'java' | awk '{print $2}')

#. ${weblogic_domain_path}/bin/stopWebLogic.sh&


if [ -z $weblogic_pid ];then
  echo "域未启动！";stop_flag=1
else
  kill -9 $weblogic_pid && stop_flag=1 || stop_flag=0 
fi

if [ $stop_flag == 1 ];then
  echo "启动中!"
  if [ ! -d '/logs/$1' ];then
     mkdir /logs/$1
  fi
  mv /logs/$1_*.log /logs/bak/$1/
  nohup $weblogic_domain_path/bin/startWebLogic.sh >>$log_path&
else
  echo "停止失败";exit 1
fi

if [ $2 == l ];then
 read -p "是否查看日志y/n" readlog

 if [ $readlog == y ];then
   tail -1000f $log_path
 fi
fi

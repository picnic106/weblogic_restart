weblogic_restart
================

linux上weblogic重启脚本


在linux上重启weblogic，需要几个步骤，

1，先进入目录

2，根据脚本找到weblogic相关进程：lsof $weblogic_domain_path|grep 'java' | awk '{print $2}'

3，杀掉进程：kill -9 $weblogic_pid

4，重启：nohup $weblogic_domain_path/bin/startWebLogic.sh >>$log_path&

这个脚本是将这几个步骤放到一个脚本，一次运行就ok。

运行之前需要设置WEBLOGIC_PATH环境变量，WEBLOGIC_PATH为你weblogic的根目录。

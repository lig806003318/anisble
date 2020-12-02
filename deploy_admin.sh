#!/bin/bash

api1=103.142.249.13
api2=103.142.249.10
agent=103.142.249.22
project_name=usdt-yinni-1
project_path=/project/$1/api
name=usdt
nginx_path=/usr/local/openresty/nginx/conf/vhost/
deploy_time=`date +%Y%m%d%H`


#备份a
ssh  root@${api1} "cd ${project_path} && tar -cvzf ${project_name}.admin.${deploy_time}.tar.gz  ./*"
ssh  root@${api1} "cd ${project_path} && mv ${project_name}.admin.${deploy_time}.tar.gz /back/admin"
#发布a
ssh  root@${agent} "cd ${nginx_path} && bash deploy_${name}.sh a"
#传输a
cp  -Crp  okex-enterprise/okex-admin/target/okex-admin.jar   root@${api1}:/project/${project_name}/api/
ssh  root@${api1} "cd ${project_path} && bash badmin.sh stop 2> 1.txt || rm -rf 1.txt "
ssh  root@${api1} "cd ${project_path} &&rm  -rf ${project_name}.jar"
ssh  root@${api1} "cd ${project_path} && mv  okex-admin.jar ${project_name}.jar && bash badmin.sh start"
ssh  root@${agent} "cd ${nginx_path} && bash deploy_${name}.sh restore"

#备份b
ssh  root@${api2} "cd ${project_path} && tar -cvzf ${project_name}.admin.${deploy_time}.tar.gz  ./*"
ssh  root@${api2} "cd ${project_path} && mv ${project_name}.admin.${deploy_time}.tar.gz /back/admin"
#发布b
ssh  root@${agent} "cd ${nginx_path} && bash deploy_${name}.sh a"
#传输b
cp  -Crp  okex-enterprise/okex-admin/target/okex-admin.jar   root@${api1}:/project/${project_name}/api/
ssh  root@${api2} "cd ${project_path} && bash badmin.sh stop 2> 1.txt || rm -rf 1.txt "
ssh  root@${api2} "cd ${project_path} &&rm  -rf ${project_name}.jar"
ssh  root@${api2} "cd ${project_path} && mv  okex-admin.jar ${project_name}.jar && bash badmin.sh start"
ssh  root@${agent} "cd ${nginx_path} && bash deploy_${name}.sh restore"



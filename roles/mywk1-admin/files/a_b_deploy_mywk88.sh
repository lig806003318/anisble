#!/bin/bash
#控制agent端 
#使用请修改变量  api  project_name  nginx_vhost_path
#发布流程      bash deploy.sh a-->bash deploy.sh restore-->bash deploy.sh b-->bash deploy.sh resore

api1=150
api2=25
project_name=mywk88
nginx_vhost_path=/usr/local/openresty/nginx/conf/vhost

function  deploy_a  {
	#更改upstream解析  注释api1
	sed -i "/${api1}/ s/^/#/" ${nginx_vhost_path}/${project_name}.conf
	/usr/local/openresty/nginx/sbin/nginx -t  >> /dev/null
	if [ $? == 0 ];then
		/usr/local/openresty/nginx/sbin/nginx -s reload
		echo 'success remove api1'
	else
		echo  "${project_name}/.conf error ,pls check ."
	fi	
}
function  deploy_b  {
	#更改upstream解析  打开api1 注释api2
	sed -i "/${api2}/ s/^/#/" ${nginx_vhost_path}/${project_name}.conf
	/usr/local/openresty/nginx/sbin/nginx -t  >> /dev/null
	if [ $? == 0 ];then
		/usr/local/openresty/nginx/sbin/nginx -s reload 
		echo 'success remove api2'
	else
		echo  "${project_name}/.conf error ,pls check ."
	fi	
}

function restore {
	sed -i 's/#//' ${nginx_vhost_path}/${project_name}.conf
	/usr/local/openresty/nginx/sbin/nginx -t  >> /dev/null
	if [ $? == 0 ];then
		/usr/local/openresty/nginx/sbin/nginx -s reload 
		echo 'success restore all'
	else
		echo  "${project_name}/.conf error ,pls check ."
	fi	
}


arg=$1

case $arg in
	a)
		deploy_a
		;;
	b) 
		deploy_b
		;;
	restore)
		restore
	        exit
	
esac






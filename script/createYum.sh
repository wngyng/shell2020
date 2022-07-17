#! /bin/bash
#label:wang
#date:22-5-10
#this is createYum

createMount(){
echo "========创建光驱挂载置========"
cdromPath="/media/cdrom"
if [ ! -d "$cdromPath" ]; then
	mkdir -p $cdromPath
	echo "$cdromPath 文件创建成功！"
else
	echo "$cdromPath 文件已存在"
fi

echo "========开始挂载虚拟光驱========"

mountpoint -q /media/cdrom
mflag=$?
if [ $mflag != 0 ]; then
	echo "开始挂载！"
	mount /dev/sr0 /media/cdrom
	mountpoint -q /media/cdrom
	mflag=$?
	if [ $mflag != 0 ]; then
		echo "虚拟光驱挂载失败,请检查虚拟光驱是否开启。程序结束！"
		exit
	else
		echo "挂载成功!"
	fi
else
	echo "已挂载!"
fi
}
createYum(){
echo "========修改yum源文件========"
cd /etc/yum.repos.d || exit
mkdir bak
ls Cen* | grep -v Media | xargs -I mv {} ./bak
sed -i 's/enabled=0/enabled=1/g' CentOS-Media.repo
echo "========清理/制造缓存========"
yum -y clean all
yum makecache
echo "========安装需要的文件========"
sleep 2
yum -y install gcc gcc-c++ make vim* lrzsz tree
echo "yum仓库创建完成！！！"
}

#epel-6公网云配置
createEpel (){
cd /etc/yum.repos.d/     
wget http://files.tttidc.com/centos6/epel-6.repo
yum clean all
yum makecache
mflag=$?
if [ $mflag != 0 ]; then
	echo "创建epel-6失败，退出程序！"
                exit
        else
                echo "创建epel-6成功"
fi
}

read -p "
================选择程序：==================
==  1、仅挂载虚拟光驱
==  2、简单挂载yum,并安装常用程序
==  3、挂载epel-6源
==  或任意键退出
==  请选择：" m
case $m in
	1)
	createMount
	;;
	2)
	createMount
	sleep 1
	createYum
	;;
	3) 
	createEpel
	;;
	*)
	echo "已退出！！！"
	exit 1
esac

#!/bin/bash
yum -y install ncurses-devel    # 安装ncurses-devel包
tar xf cmake-2.8.6.tar.gz -C /usr/src/           # 解压cmake包
 cd /usr/src/cmake-2.8.6/ || exit
./configure && gmake && gmake install    # 安装gmake

useradd -M -s /sbin/nologin mysql         # 添加mysql用户
tar xf /root/mysql-5.6.39.tar.gz -C /usr/src/       # 解压mysql

cd /usr/src/mysql-5.6.39 || exit
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DSYSCONFDIR=/etc/ -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_EXTRA_CHARSETS=all && make && make install    # 内容不要出错，详见右侧。

chown -R mysql:root /usr/local/mysql/      # 降权，修改属组属主
/bin/cp support-files/my-medium.cnf /etc/my.cnf        # 修改my.cnf配置文件
cp support-files/mysql.server /etc/init.d/mysqld    # 添加服务
chmod +x /etc/init.d/mysqld 
chkconfig mysqld --add
chkconfig mysqld --list    
echo "export PATH=$PATH:/usr/local/mysql/bin" >> /etc/profile    #添加执行命令到PATH环境变量 或者: ln -s /usr/local/mysql/bin/* /usr/local/bin/
cd ~ || exit
. /etc/profile              

/usr/local/mysql/scripts/mysql_install_db --user=mysql --basedir=/usr/local/mysql/ --datadir=/usr/local/mysql/data/    
/etc/init.d/mysqld start        
netstat -anpt |grep:3306         

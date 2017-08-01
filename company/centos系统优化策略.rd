
目前的centos7系统优化策略：

fs.file-max=655536
#此参数表示进程可以同时打开的最大句柄数，这个参数直接限制最大并发连接数。
net.ipv4.tcp_tw_reuse=1
#参数设置为1时，表示允许将TIME-WAIT状态的socket重新用于新的TCP连接。
net.ipv4.tcp_keepalive_time=600
#keepalive启用时，TCP发送keepalive消息的频度;默认2小时适当降低有利于更快清理无效的连接。
net.ipv4.tcp_fin_timeout=30
#这个参数表示当服务器主动关闭连接时，socket保持在FIN-WAIT-2状态的最大时间。
net.ipv4.tcp_max_tw_buckets=5000
#参数表示操作系统允许TIME=WAIT套接字数量的最大值，超过则TIME_WAIT立即清楚并打印错误信息;默认18000数值大服务器变慢。
net.ipv4.ip_local_port_range=1024    61000
#用于向外连接的端口范围,客户端测试并发连接超过一定数量时候，出现端口号耗尽情况，尤其被大量TIME_WAIT占用。
net.ipv4.tcp_rmem=4096    32768    262142
#参数定义在TCP接收缓存用于TCP接收滑动窗口的最小值;默认最大值。
net.ipv4.tcp_wmem=4096    32768    262142
#参数定义在TCP发送缓存用于TCP发送滑动窗口的最小值;默认最大值。
net.core.netdev_max_backlog=8096
#网卡接收数据包的速度大于内核处理的速度时，在队列中保存这些数据包，参数表示该队列的最大值。
net.core.rmem_default=262144
net.core.wmem_default=262144
net.core.rmem_max=2097152
net.core.wmem_max=2097152
net.ipv4.tcp_syncookies=1
net.ipv4.tcp_max_syn_backlog=10000

使用 ulimit -n 65535 可即时修改，但重启后就无效了。（注ulimit -SHn 65535 等效 ulimit -n 65535，-S指soft，-H指hard)
有如下三种修改方式：
1.在/etc/rc.local 中增加一行 ulimit -SHn 65535
2.在/etc/profile 中增加一行 ulimit -SHn 65535
3.在/etc/security/limits.conf最后增加如下两行记录
* soft nofile 65535
* hard nofile 65535
修改openfile

/etc/security/limits.d/20-nproc.conf
修改max process

配置完服务器记得调时钟，时区。
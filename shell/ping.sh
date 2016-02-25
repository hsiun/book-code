#!/bin/bash
# 文件名：ping.sh
# 用途：根据配置对某网段的ip进行ping探测

for ip in 192.168.0.{1..255;
do
	（
		ping $ip -c 2 &> /dev/null;

		if [ $? -eq 0 ]; then
			echo $ip is alive
		fi
	）&
done
wait

# 此脚本较简单，下面附带fping的用法
# 效果是一样的
# fping -a 192.168.0.1 192.168.0.255 -g
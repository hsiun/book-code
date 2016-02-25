#!/bin/bash
# 文件名：find_broken.sh
# 用途：从网站中找出坏链（无效链接）


if [ $# -ne 1];
then
	echo -e "$Usage: $0 URL\n"
	exit 1;
fi 

echo Broken Links:

#为lynx创建工作目录
mkdir /tmp/$$.lynx
cd /tmp/$$.lynx

#使用lynx -traversal命令获取链接
lynx -traversal $1 > /dev/null
count=0;

#排序去重，并将结果写入links.txt文件
sort -u reject.dat > links.txt

#使用curl命令获取无法访问的 链接
while read link;
do
	output='curl -I $link -s | grep "HTTP/.*OK"';
	if [[ -z $output ]]; then
		echo $link;
		let count++
	fi
done < links.txt

[ $count -eq 0 ] && echo No broken links found.
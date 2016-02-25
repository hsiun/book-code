# !/bin/bash
# 文件名：filestat.sh
# 用法：./filestat.sh /path/to/filename

if [ $# -ne 1 ]; 
then
	echo "Usage is $0 /path/to/filename";
	exit
fi

path $1

declare -A statarray;

while read line; 
# 使用file -b命令获取文件信息
do
	ftype='file -b "$line" | cut -d, -f1'
	let statarray["$ftype"]++;
done < < (find $path -type f -print)
# 这里是两个分开的<用子进程输出来替代文件名

echo ================= File types and counts =================
for ftype in "${!statarray[@]}";
do
	echo $ftype : ${statarray["ftype"]}
done

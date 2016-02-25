# !/bin/bash
# 文件名：remove_duplicates.sh
# 用途：查找并删除重复文件，每一个文件只保留一个副本
# 原理：先按文件大小排序，然后依次比较两个文件MD5值，相同的删除
# 状态：未测试


# 在begin中读取两行，第一行丢弃，第二行保留第8列文件名和第5列文件大小
# 在awk执行体中获取下一行文件名保存在name2中，如果文件大小一样则计算MD5值，如果
# 一样则输出，最终结果会被写入duplicate_file，最后将保留文件名和文件大小，进入下一次
ls -lS --time-style=long-iso | awk 'BEGIN {

	getline; getline;
	name1=$8; size=$5
}{
	name2=$8;
	if (size==$5)
	{
		"md5sum "name1 | getline; csum1=$1;
		"md5sum "name2 | getline; csum2=$1;
		if ( csum2==csum1 )
		{
			print name1; print name2
		}
	};

	size=$5; name1=name2;
}' | sort -u > duplicate_files

# 去除duplicate_files中重复的行，写入duplicate_sample
cat duplicate_files | xargs -I {} md5sum {} | sort | uniq -w 32 | awk '{ print
"^"$2"$" }' | sort -u > duplicate_sample

# 删除在duplicate_files中的但是不在duplicate_sample文件
echo Removing. . .
comm dumplicate_files duplicate_sample -2 -3 | tee /dev/strerr | xargs rm 
echo Removed duplicates files successfully.
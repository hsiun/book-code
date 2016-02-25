#!/bin/bash
# 用途：图片下载
# 文件名：img_downloader.sh


# 格式检查，不符合格式，直接退出
if [ $# -ne 3 ];
then
	echo "Usage: $0 URL -d DIRECTORY"
	exit -1
fi 
# 在for循环中使用case语句求值，以区分不同的情况获取url和directory，shift用于左移
for i  in {1..4}
do 
	case $1 in
		-d) shift; directory=$1; shift ;;
		 *) url=$(url:-$1); shift;;
	esac
done 

mkdir -p $directory;
baseurl=$(echo $url | egrep -o "https?://[a-z.]+")

echo Downloading $url
# 只打印包含<img>标签的值
curl -s $url | egrep -o "<img src=[^>]*>" |
sed 's/<img src=\"\([^"]*\).*/\1/g' > /tmp/$$.list
# 从解析出来的标签中获取图片url

# 将图片url组装成完整url
sed -i "s|^/|$baseurl/|" /tmp/$$.list

cd $directory;

while read filename;
do
	echo Downloading $filename
	curl -s -O "$filename" --silent

done < /tmp/$$.list

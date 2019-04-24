#! /bin/sh

# you can do something here
# this shell scripts will run at the end of build.py scripts
mkdir -p history
if [ ! -f ./history/version ];then
	touch ./history/version
fi

version_old=`cat history/version | awk '{print $1}' | sort -rn |sed -n 1p`
version_new=`cat config.json.js |grep -w "version"|cut -d"\"" -f 4|grep -v Soft`
md5_old=`cat history/version | sort -nk1 | awk '{print $1}' |sed -n 1p`
md5_new=` md5sum softether.tar.gz | awk '{print $1}'`

if [ -f ./softether.tar.gz ];then
	if [ "$version_old" != "$version_new" ];then
		mkdir ./history/$version_new/
		cp -rf ./softether.tar.gz ./history/$version_new/
		echo $version_new $md5_new >> ./history/version
	fi
fi

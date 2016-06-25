#!/bin/bash
# SET variables
if [ $# -eq 1 ]
then
	PTH=$1
	USR="www-data"
elif [ $# -eq 2 ]
then
	PTH=$1
	USR=$2
else
	echo "Incorrect argument count we atleast need a path to wordpress installation"
	exit
fi
##
## Wordpress scanner via wpscan api location
## https://github.com/anantshri/wpvulndb_commandline
##
WPSCANAPI=$HOME/bin/wpscanapi
##
## Check the instance is a wordpress or not
##
wp --path=$PTH core is-installed
status=$?
if [ $status -ne 0 ]
then
	echo "Input Recieved : " $PTH
	echo "Not a wordpress installation"
	exit
else
	# Done
	echo "############# CHECKSUM VERIFICATIONS CORE ##########"
	wp --path=$PTH core verify-checksums
	echo "##### Looking for files uploaded by webuser except common extension #####"
	ls -lRt $PTH | grep $USR | egrep -v "^d|png|jpg|gif|doc|pdf|tif|jpeg|bmp|zip|pptx|docx|ppt|js|css|txt"
	echo "######  wpscanapi check for issues #########"
	python $WPSCANAPI --vuln --wordpress $PTH 2>/dev/null
	echo "###### WP CORE UPDATE CHECK #################"
	wp --path=$PTH core check-update
	echo "######  wp plugin update pending  ###########"
	wp --path=$PTH plugin list --fields=name,update,version | grep "available"
	echo "#####  wp theme update pending  ###########"
	wp --path=$PTH theme list --fields=name,update,version | grep "available"
	echo "#####  404 on repository checker #####"
	wp --path=$PTH plugin list --fields=name | tr ' ' '\n' | grep -v "name" | xargs -L 1  -I {} curl -I -w "%{http_code} %{url_effective}\\n" https://wordpress.org/plugins/{}/ -o /dev/null 2>/dev/null | grep -v "200 "
	wp --path=$PTH theme list --fields=name | tr ' ' '\n' | grep -v "name" | xargs -L 1  -I {} curl -I -w "%{http_code} %{url_effective}\\n" https://wordpress.org/themes/{}/ -o /dev/null 2>/dev/null | grep -v "200 "
	echo "###### ADMIN USER LIST ##########"
	wp --path=$PTH user list --role=administrator
	echo "###### REPORT DONE #####"
fi

#!/bin/sh

alias echo_date1='echo $(date +%Y年%m月%d日\ %X)'
export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
eval `dbus export koolproxy_`
mkdir -p /tmp/upload
# this part for start up
case $1 in
start)
	sh /koolshare/koolproxy/kp_config.sh stop > /tmp/upload/kp_log.txt
	# the soft link should be create after boot
	[ ! -L "/tmp/upload/user.txt" ] && ln -sf $KSROOT/koolproxy/data/user.txt /tmp/upload/user.txt
	[ "$koolproxy_enable" == "1" ] && sh /koolshare/koolproxy/kp_config.sh start > /tmp/upload/kp_log.txt
	;;
stop)
	sh /koolshare/koolproxy/kp_config.sh stop > /tmp/upload/kp_log.txt
	;;
esac

# this part for web runing using httpdb
case $2 in
1)
	if [ "$koolproxy_enable" == "1" ];then
		sh /koolshare/koolproxy/kp_config.sh restart > /tmp/upload/kp_log.txt 2>&1
	else
		sh /koolshare/koolproxy/kp_config.sh stop > /tmp/upload/kp_log.txt 2>&1
	fi
	echo XU6J03M6 >> /tmp/upload/kp_log.txt
	http_response "$1"
	;;
3)
	sh /koolshare/koolproxy/kp_rule_update.sh > /tmp/upload/kp_log.txt 2>&1
	echo XU6J03M6 >> /tmp/upload/kp_log.txt
	http_response "$1"
	;;
esac



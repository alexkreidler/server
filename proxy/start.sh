#!/bin/sh -ex
/sbin/syslogd -O /proc/1/fd/1   # <--- link to docker's stdout, not "your stdout"
# /usr/local/sbin/haproxy -p /run/haproxy.pid -f /usr/local/etc/haproxy/haproxy.cfg -Ds
haproxy -f /usr/local/etc/haproxy/haproxy.cfg -db  # <--- stay in foreground

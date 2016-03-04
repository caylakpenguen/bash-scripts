#!/bin/bash
# caylakpenguen 7 Subat 2016
# web istatistikleri icindir
/usr/bin/webalizer -c /root/vhost-webalizer.conf >>/root/webalizer.log 1>/dev/null 2>/dev/null
/usr/bin/webalizer -c /root/caylak-webalizer.conf >>/root/webalizer.log 1>/dev/null 2>/dev/null
/usr/bin/webalizer -c /root/kimgelir-webalizer.conf >>/root/webalizer.log 1>/dev/null 2>/dev/null



#!/bin/bash
# Default the TZ environment variable to UTC.
TZ=${TZ:-CST}
export TZ

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

cd /tmp
curl https://gitee.com/xjh2009/hxscript/raw/master/free.sh -O 
sed -i 's/\r//' free.sh
chmod -R 777 /tmp/free.sh
bash /tmp/free.sh

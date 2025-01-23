#!/bin/bash

# 启动 PPTP 服务
pptpd &

# 等待 PPTP 服务启动
sleep 5

# 获取容器的 IP 地址
CONTAINER_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')

# 配置 iptables 转发规则
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i ppp0 -o eth0 -j ACCEPT
iptables -A FORWARD -i eth0 -o ppp0 -j ACCEPT

# 启动 tun2socks
tun2socks -device tun0 -proxyType socks5 -proxyServer 192.168.120.2:20170 -tunAddr 10.0.0.2 -tunGw 10.0.0.1 -netif-ipaddr $CONTAINER_IP -dnsServer 8.8.8.8,8.8.4.4 &

# 保持容器运行
tail -f /dev/null

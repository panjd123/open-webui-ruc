#!/bin/bash

# 遍历端口范围 8081 到 8096
for port in {8081..8096}
do
  # 查找监听该端口的进程
  pid=$(lsof -t -i :$port)
  
  # 如果找到了进程，杀掉它
  if [ -n "$pid" ]; then
    echo "Killing process $pid on port $port"
    kill -9 $pid
  fi
done

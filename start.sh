#!/bin/bash
# 局域网设备智能监控可视化大屏 - 快速启动脚本

# 检查是否在正确目录
if [ ! -d "app" ] || [ ! -d "venv" ]; then
    echo "错误: 请在安装目录下运行此脚本。"
    exit 1
fi

# 激活虚拟环境
if [ -f "venv/bin/activate" ]; then
    source venv/bin/activate
elif [ -f "venv/Scripts/activate" ]; then
    source venv/Scripts/activate
else
    echo "错误: 无法找到虚拟环境。请先运行 install.sh 安装系统。"
    exit 1
fi

# 启动应用
echo "正在启动局域网设备智能监控可视化大屏..."
cd app
python start.py

# 如果应用异常退出，保持终端窗口
if [ $? -ne 0 ]; then
    echo "应用异常退出。按任意键关闭窗口..."
    read -n 1
fi

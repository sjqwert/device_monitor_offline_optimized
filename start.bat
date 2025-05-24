@echo off
REM 局域网设备智能监控可视化大屏 - 快速启动脚本 (Windows版)

REM 检查是否在正确目录
if not exist "app" (
    echo 错误: 请在安装目录下运行此脚本。
    pause
    exit /b 1
)

if not exist "venv" (
    echo 错误: 请在安装目录下运行此脚本。
    pause
    exit /b 1
)

REM 激活虚拟环境
if exist "venv\Scripts\activate.bat" (
    call venv\Scripts\activate.bat
) else (
    echo 错误: 无法找到虚拟环境。请先运行 install.bat 安装系统。
    pause
    exit /b 1
)

REM 启动应用
echo 正在启动局域网设备智能监控可视化大屏...
cd app
python start.py

REM 如果应用异常退出，保持终端窗口
if %ERRORLEVEL% neq 0 (
    echo 应用异常退出。按任意键关闭窗口...
    pause
)

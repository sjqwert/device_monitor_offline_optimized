@echo off
REM 局域网设备智能监控可视化大屏 - 离线安装脚本 (Windows版)

echo === 局域网设备智能监控可视化大屏 - 离线安装 ===
echo 正在准备安装环境...

REM 检查Python版本
where python >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo 错误: 未找到Python。请安装Python 3.8或更高版本后重试。
    pause
    exit /b 1
)

REM 检查Python版本是否满足要求
for /f "tokens=2" %%i in ('python -c "import sys; print(sys.version.split()[0])"') do set PYTHON_VERSION=%%i
for /f "tokens=1,2 delims=." %%a in ("%PYTHON_VERSION%") do (
    set PYTHON_MAJOR=%%a
    set PYTHON_MINOR=%%b
)

if %PYTHON_MAJOR% LSS 3 (
    echo 错误: Python版本过低。需要Python 3.8或更高版本，当前版本: %PYTHON_VERSION%
    pause
    exit /b 1
)

if %PYTHON_MAJOR% EQU 3 (
    if %PYTHON_MINOR% LSS 8 (
        echo 错误: Python版本过低。需要Python 3.8或更高版本，当前版本: %PYTHON_VERSION%
        pause
        exit /b 1
    )
)

echo 检测到Python版本: %PYTHON_VERSION% (符合要求)

REM 创建虚拟环境
echo 正在创建Python虚拟环境...
python -m venv venv
if %ERRORLEVEL% neq 0 (
    echo 错误: 创建虚拟环境失败。请确保已安装venv模块。
    pause
    exit /b 1
)

REM 激活虚拟环境
if exist "venv\Scripts\activate.bat" (
    call venv\Scripts\activate.bat
) else (
    echo 错误: 无法激活虚拟环境。
    pause
    exit /b 1
)

echo 已激活Python虚拟环境

REM 安装依赖
echo 正在安装依赖包(离线模式)...
pip install --no-index --find-links=wheels -r app\requirements.txt
if %ERRORLEVEL% neq 0 (
    echo 错误: 安装依赖包失败。
    pause
    exit /b 1
)

echo 依赖包安装完成

REM 初始化数据库
echo 正在初始化数据库...
cd app
python src\database\init_db.py
if %ERRORLEVEL% neq 0 (
    echo 警告: 数据库初始化可能未完全成功，但这不影响系统基本功能。
)

echo === 安装完成 ===
echo 您可以通过以下命令启动系统:
echo   1. 激活虚拟环境: venv\Scripts\activate
echo   2. 进入应用目录: cd app
echo   3. 启动应用: python start.py
echo.
echo 或者直接运行启动脚本: start.bat

pause

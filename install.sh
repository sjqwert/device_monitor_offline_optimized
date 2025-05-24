#!/bin/bash
# 局域网设备智能监控可视化大屏 - 离线安装脚本

echo "=== 局域网设备智能监控可视化大屏 - 离线安装 ==="
echo "正在准备安装环境..."

# 检查Python版本
if command -v python3 &>/dev/null; then
    PYTHON_CMD=python3
elif command -v python &>/dev/null; then
    PYTHON_CMD=python
else
    echo "错误: 未找到Python。请安装Python 3.8或更高版本后重试。"
    exit 1
fi

# 检查Python版本是否满足要求
PYTHON_VERSION=$($PYTHON_CMD -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
PYTHON_MAJOR=$(echo $PYTHON_VERSION | cut -d. -f1)
PYTHON_MINOR=$(echo $PYTHON_VERSION | cut -d. -f2)

if [ "$PYTHON_MAJOR" -lt 3 ] || ([ "$PYTHON_MAJOR" -eq 3 ] && [ "$PYTHON_MINOR" -lt 8 ]); then
    echo "错误: Python版本过低。需要Python 3.8或更高版本，当前版本: $PYTHON_VERSION"
    exit 1
fi

echo "检测到Python版本: $PYTHON_VERSION (符合要求)"

# 创建虚拟环境
echo "正在创建Python虚拟环境..."
$PYTHON_CMD -m venv venv
if [ $? -ne 0 ]; then
    echo "错误: 创建虚拟环境失败。请确保已安装venv模块。"
    exit 1
fi

# 激活虚拟环境
if [ -f "venv/bin/activate" ]; then
    source venv/bin/activate
elif [ -f "venv/Scripts/activate" ]; then
    source venv/Scripts/activate
else
    echo "错误: 无法激活虚拟环境。"
    exit 1
fi

echo "已激活Python虚拟环境"

# 安装依赖
echo "正在安装依赖包(离线模式)..."
pip install --no-index --find-links=wheels -r app/requirements.txt
if [ $? -ne 0 ]; then
    echo "错误: 安装依赖包失败。"
    exit 1
fi

echo "依赖包安装完成"

# 初始化数据库
echo "正在初始化数据库..."
cd app
python src/database/init_db.py
if [ $? -ne 0 ]; then
    echo "警告: 数据库初始化可能未完全成功，但这不影响系统基本功能。"
fi

echo "=== 安装完成 ==="
echo "您可以通过以下命令启动系统:"
echo "  1. 激活虚拟环境: source venv/bin/activate (Linux/Mac) 或 venv\\Scripts\\activate (Windows)"
echo "  2. 进入应用目录: cd app"
echo "  3. 启动应用: python start.py"
echo ""
echo "或者直接运行启动脚本: ./start.sh"

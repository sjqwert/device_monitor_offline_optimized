局域网设备智能监控可视化大屏 - 离线部署指南
系统概述
局域网设备智能监控可视化大屏是一个完整的设备监控系统，支持设备状态实时监控、历史数据查询、告警管理和设备管理等功能。本系统已完全本地化，所有依赖和资源均可离线安装和使用。
系统要求
操作系统：Windows 7/10/11、Linux 或 macOS
Python：3.8 或更高版本
存储空间：至少 500MB 可用空间
可选组件：
Mosquitto MQTT Broker（用于设备通信）
InfluxDB（用于时序数据存储）
离线部署步骤
1. 解压部署包
将 device_monitor_offline.zip 解压到您选择的目录，例如：
C:\DeviceMonitor
或
/home/user/DeviceMonitor
2. 运行安装脚本
Windows 环境：
打开命令提示符或 PowerShell，进入解压目录：
cd C:\DeviceMonitor
.\install.bat
Linux/macOS 环境：
打开终端，进入解压目录：
cd /home/user/DeviceMonitor
chmod +x install.sh
./install.sh
安装脚本将自动：
检查 Python 版本
创建虚拟环境
安装所有依赖（离线模式）
初始化数据库
3. 启动系统
Windows 环境：
.\start.bat
Linux/macOS 环境：
chmod +x start.sh
./start.sh
启动脚本将自动：
激活虚拟环境
启动所有必要服务
打开浏览器访问系统
系统功能说明
监控大屏
设备列表：显示所有已注册设备及其状态
实时监控：查看选定设备的实时参数和趋势图
历史数据：查询和分析设备历史数据
告警信息：显示设备告警和异常状态
设备管理
添加设备：添加新设备到监控系统
删除设备：从系统中移除不需要监控的设备
常见问题解答
1. 系统无法启动
检查：
Python 版本是否满足要求（3.8+）
是否已正确运行安装脚本
查看日志文件（logs 目录）获取详细错误信息
2. 无法看到设备数据
检查：
设备是否已添加到系统
MQTT 服务是否正常运行
设备是否正确配置了 MQTT 连接参数
3. 数据库初始化失败
解决方案：
确保用户对安装目录有写入权限
手动运行初始化脚本：python src/database/init_db.py
技术支持
如需进一步的技术支持，请联系系统管理员或开发团队。

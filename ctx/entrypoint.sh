#!/usr/bin/env sh
set -eu

# 默认环境变量
: "${SC_PORT:=25500}"
: "${SC_ADDR:=0.0.0.0}"
: "${SC_ARGS:=}"

# subconverter 主程序路径
BIN="/opt/subconverter/subconverter"

# 如果程序不可执行，自动赋权
if [ ! -x "$BIN" ]; then
  echo "🔧 subconverter binary not executable, fixing permission..."
  chmod +x "$BIN" || true
fi

# 启动服务
echo "🚀 Starting subconverter on ${SC_ADDR}:${SC_PORT}"
exec "$BIN" -localaddr "${SC_ADDR}:${SC_PORT}" ${SC_ARGS}

# === Install subconverter and setup entrypoint ===

# 暴露 subconverter 默认端口
EXPOSE 25500

# 环境变量（默认监听 0.0.0.0:25500）
ENV SC_PORT=25500 SC_ADDR=0.0.0.0

# 复制启动脚本
COPY entrypoint.sh /entrypoint.sh

# 赋予执行权限
RUN chmod +x /entrypoint.sh || true

# 启动命令
ENTRYPOINT ["/entrypoint.sh"]

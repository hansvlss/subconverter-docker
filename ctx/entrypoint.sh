#!/usr/bin/env sh
set -eu

# 默认环境变量
: "${SC_PORT:=25500}"
: "${SC_ADDR:=0.0.0.0}"
: "${SC_ARGS:=}"

BIN="/opt/subconverter/subconverter"

# 检查 subconverter 是否存在
if [ ! -f "$BIN" ]; then
  echo "❌ subconverter binary not found at $BIN"
  exit 1
fi

# 检查是否有执行权限
if [ ! -x "$BIN" ]; then
  echo "⚙ subconverter binary not executable, fixing permission..."
  chmod +x "$BIN" || true
fi

# 启动服务
echo "🚀 Starting subconverter on ${SC_ADDR}:${SC_PORT}"
exec "$BIN" -localaddr "${SC_ADDR}:${SC_PORT}" ${SC_ARGS}

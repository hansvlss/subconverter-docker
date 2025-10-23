#!/usr/bin/env sh
set -eu

: "${SC_PORT:=25500}"
: "${SC_ADDR:=0.0.0.0}"
: "${SC_ARGS:=}"

BIN="/opt/subconverter/subconverter"

# 若程序不存在
if [ ! -f "$BIN" ]; then
  echo "❌ subconverter binary not found at $BIN"
  exit 1
fi

# 若程序不可执行，则赋予权限
if [ ! -x "$BIN" ]; then
  echo "⚙️ subconverter binary not executable, fixing permission..."
  chmod +x "$BIN" || chmod 755 "$BIN" || true
fi

# 再次确认权限
ls -l "$BIN"

# 启动服务
echo "🚀 Starting subconverter on ${SC_ADDR}:${SC_PORT}"
exec "$BIN" -localaddr "${SC_ADDR}:${SC_PORT}" ${SC_ARGS}

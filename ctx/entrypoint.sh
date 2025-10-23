#!/bin/bash
set -e

# 默认端口和监听地址
SC_PORT=${SC_PORT:-25500}
SC_ADDR=${SC_ADDR:-0.0.0.0}

echo "🚀 Starting subconverter..."
echo "🌐 Listen: ${SC_ADDR}:${SC_PORT}"

# 运行 subconverter
cd /opt/subconverter
exec ./subconverter -addr "${SC_ADDR}" -port "${SC_PORT}"

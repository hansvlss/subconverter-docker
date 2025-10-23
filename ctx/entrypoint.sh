#!/usr/bin/env sh
set -eu

: "${SC_PORT:=25500}"
: "${SC_ADDR:=0.0.0.0}"
: "${SC_ARGS:=}"

BIN="/opt/subconverter/subconverter"

if [ ! -f "$BIN" ]; then
  echo "❌ subconverter binary not found at $BIN"
  exit 1
fi

if [ ! -x "$BIN" ]; then
  echo "⚙️ subconverter binary not executable, fixing permission..."
  chmod +x "$BIN" || true
fi

echo "🚀 Starting subconverter on ${SC_ADDR}:${SC_PORT}"
exec "$BIN" -localaddr "${SC_ADDR}:${SC_PORT}" ${SC_ARGS}

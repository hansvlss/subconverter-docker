FROM debian:bullseye-slim

WORKDIR /opt/subconverter

# 安装基础依赖
RUN apt-get update && apt-get install -y curl tar && \
    rm -rf /var/lib/apt/lists/*

# 自动检测架构并下载 subconverter 二进制
RUN bash -c '\
ARCH=$(uname -m); \
case "$ARCH" in \
  x86_64) ARCH=linux64 ;; \
  aarch64) ARCH=linux-arm64 ;; \
  armv7l) ARCH=linux-armv7 ;; \
  *) ARCH=linux64 ;; \
esac; \
echo ">>> Detected ARCH=$ARCH"; \
curl -L -o subconverter.tar.gz https://github.com/tindy2013/subconverter/releases/latest/download/subconverter_${ARCH}.tar.gz; \
tar -xzf subconverter.tar.gz --strip-components=1; \
chmod +x subconverter; \
rm subconverter.tar.gz'

# 拷贝启动脚本
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 25500

ENTRYPOINT ["/entrypoint.sh"]

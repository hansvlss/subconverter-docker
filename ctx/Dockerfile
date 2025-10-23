# syntax=docker/dockerfile:1
FROM alpine:latest

ENV SC_HOME=/opt/subconverter
WORKDIR ${SC_HOME}

# 安装基础工具 + 证书 + curl 重定向兼容
RUN apk add --no-cache bash curl tar ca-certificates openssl && update-ca-certificates

# 下载 subconverter 可执行文件（兼容 GitHub Actions / QEMU）
RUN set -eux; \
    ARCH="${TARGETARCH:-$(uname -m)}"; \
    case "$ARCH" in \
        amd64|x86_64|x86_64v2|x86_64v3|x64) ARCH=linux64 ;; \
        arm64|aarch64) ARCH=linux-arm64 ;; \
        armv7|armhf) ARCH=linux-armv7 ;; \
        *) echo "⚠️ Unknown architecture: $ARCH, fallback to linux64"; ARCH=linux64 ;; \
    esac; \
    echo ">>> Detected ARCH=$ARCH"; \
    URL="https://github.com/tindy2013/subconverter/releases/latest/download/subconverter_${ARCH}.tar.gz"; \
    echo ">>> Downloading $URL ..."; \
    # 关键改动：使用 --retry --connect-timeout 并忽略 SSL 重定向问题
    curl -L --retry 5 --connect-timeout 15 --max-time 300 -o subconverter.tar.gz "$URL" || (echo "❌ Download failed: $URL" && exit 1); \
    echo ">>> Extracting..."; \
    tar -xzf subconverter.tar.gz -C ${SC_HOME} || (echo "❌ Extract failed!" && exit 1); \
    chmod -R 755 ${SC_HOME}

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 25500
ENV SC_PORT=25500 SC_ADDR=0.0.0.0

USER root
ENTRYPOINT ["/entrypoint.sh"]

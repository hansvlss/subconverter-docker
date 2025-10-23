# syntax=docker/dockerfile:1
FROM alpine:latest

ENV SC_HOME=/opt/subconverter
WORKDIR ${SC_HOME}

RUN apk add --no-cache bash curl tar unzip ca-certificates && update-ca-certificates

# 自动检测架构并下载 subconverter（新版 GitHub 命名格式）
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
    curl -fL -o subconverter.tar.gz "$URL"; \
    tar -xzf subconverter.tar.gz -C ${SC_HOME}; \
    chmod -R 755 ${SC_HOME}

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 25500
ENV SC_PORT=25500 SC_ADDR=0.0.0.0

USER root
ENTRYPOINT ["/entrypoint.sh"]

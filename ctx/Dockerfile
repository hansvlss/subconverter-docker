# syntax=docker/dockerfile:1
FROM alpine:latest

# 设置环境变量
ENV SC_HOME=/opt/subconverter
WORKDIR ${SC_HOME}

# 安装依赖
RUN apk add --no-cache bash curl tar unzip ca-certificates && update-ca-certificates

# 自动检测架构（支持 buildx 和传统 docker）
RUN set -eux; \
    ARCH="${TARGETARCH:-$(uname -m)}"; \
    case "$ARCH" in \
        amd64|x86_64) ARCH=linux64 ;; \
        arm64|aarch64) ARCH=linuxarm64 ;; \
        armv7|armhf) ARCH=linuxarmv7 ;; \
        *) echo "❌ Unsupported architecture: $ARCH" && exit 1 ;; \
    esac; \
    echo ">>> Detected ARCH=$ARCH"; \
    echo ">>> Downloading subconverter binary..."; \
    curl -L -o subconverter.tar.gz "https://github.com/tindy2013/subconverter/releases/latest/download/subconverter_${ARCH}.tar.gz"; \
    tar -xzf subconverter.tar.gz -C ${SC_HOME}; \
    chmod -R 755 ${SC_HOME}

# 复制启动脚本
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 暴露端口
EXPOSE 25500
ENV SC_PORT=25500 SC_ADDR=0.0.0.0

# 以 root 运行，避免权限问题
USER root

# 启动命令
ENTRYPOINT ["/entrypoint.sh"]

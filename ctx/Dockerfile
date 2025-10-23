# syntax=docker/dockerfile:1
FROM alpine:latest

# 设置工作目录和环境变量
ENV SC_HOME=/opt/subconverter
WORKDIR ${SC_HOME}

# 安装依赖
RUN apk add --no-cache bash curl unzip tar

# 下载 subconverter 可执行文件（自动匹配架构）
RUN set -eux; \
    case "$(uname -m)" in \
      x86_64) ARCH=linux64 ;; \
      aarch64) ARCH=linuxarm64 ;; \
      armv7l) ARCH=linuxarmv7 ;; \
      *) echo "❌ Unsupported architecture: $(uname -m)" && exit 1 ;; \
    esac; \
    echo ">>> Downloading subconverter for $ARCH ..."; \
    curl -L -o subconverter.tar.gz "https://github.com/tindy2013/subconverter/releases/latest/download/subconverter_${ARCH}.tar.gz"; \
    tar -xzf subconverter.tar.gz -C ${SC_HOME} || true; \
    chmod +x ${SC_HOME}/subconverter || true

# 复制启动脚本
COPY ctx/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh || true

# 暴露端口
EXPOSE 25500
ENV SC_PORT=25500 SC_ADDR=0.0.0.0

# 启动命令
ENTRYPOINT ["/entrypoint.sh"]

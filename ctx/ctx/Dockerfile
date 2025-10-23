# syntax=docker/dockerfile:1
FROM alpine:latest

# 环境变量
ENV SC_HOME=/opt/subconverter

# 安装必要依赖
RUN apk add --no-cache bash curl unzip tar

# 创建目录
RUN mkdir -p ${SC_HOME}

# 下载 subconverter 发行包（自动判断架构）
RUN set -eux; \
    case "$(uname -m)" in \
      x86_64) ARCH=linux64 ;; \
      aarch64) ARCH=linuxarm64 ;; \
      armv7l) ARCH=linuxarmv7 ;; \
      *) echo "Unsupported arch: $(uname -m)" && exit 1 ;; \
    esac; \
    echo ">>> downloading subconverter for $ARCH"; \
    curl -L -o /tmp/subconverter.tar.gz "https://github.com/tindy2013/subconverter/releases/latest/download/subconverter_${ARCH}.tar.gz"; \
    tar -xzf /tmp/subconverter.tar.gz -C ${SC_HOME}; \
    chmod +x ${SC_HOME}/subconverter || true

# 复制启动脚本
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh || true

# 暴露端口
EXPOSE 25500

# 默认环境变量
ENV SC_PORT=25500 SC_ADDR=0.0.0.0

# 启动命令
ENTRYPOINT ["/entrypoint.sh"]

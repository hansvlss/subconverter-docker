# syntax=docker/dockerfile:1
FROM alpine:latest

ENV SC_HOME=/opt/subconverter
WORKDIR ${SC_HOME}

RUN apk add --no-cache bash ca-certificates && update-ca-certificates

# 将 GitHub Actions 预下载的 subconverter 拷贝进来
COPY tmp/subconverter ${SC_HOME}/subconverter

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh ${SC_HOME}/subconverter

EXPOSE 25500
ENV SC_PORT=25500 SC_ADDR=0.0.0.0

ENTRYPOINT ["/entrypoint.sh"]

ARG VERSION
FROM golang:1.22-bullseye as go

COPY devtools /devtools

RUN \
    apt-get update && \
    apt-get install -y upx-ucl && \
    cd /devtools && \
    go test -race && \
    GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" && \
    upx /devtools/devtools

FROM selenoid/dev_yandex:$VERSION

COPY yandexdriver /usr/bin/
COPY entrypoint.sh /
COPY --from=go /devtools/devtools /usr/bin/

RUN \
    chmod +x /usr/bin/yandexdriver && \
    echo "cookie-file = ~/.config/pulse/cookie" >> /etc/pulse/client.conf

USER selenium

EXPOSE 4444
EXPOSE 7070
ENTRYPOINT ["/entrypoint.sh"]

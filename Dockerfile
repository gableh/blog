FROM golang:1.12.6-alpine3.9

ENV VERSION 0.55.6

RUN apk add git && \
  busybox wget https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_${VERSION}_linux-64bit.tar.gz && \
  tar -xzvf hugo_${VERSION}_linux-64bit.tar.gz && \
  rm -f hugo_${VERSION}_linux-64bit.tar.gz && \
  mv hugo /usr/local/bin/hugo

COPY entrypoint.sh ./entrypoint.sh

ENTRYPOINT ["sh", "-c", "./entrypoint.sh"]



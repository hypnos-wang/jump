FROM alpine:edge

RUN apk update && \
    apk add --no-cache ca-certificates caddy wget && \
    rm -rf /var/cache/apk/*

COPY init.sh /init.sh
RUN chmod +x /init.sh

CMD /init.sh

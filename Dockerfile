FROM alpine:edge

# get packages we need
RUN apk update && \
    apk add --no-cache ca-certificates caddy wget && \
    rm -rf /var/cache/apk/*

# init
ADD init.sh /init.sh
RUN chmod +x /init.sh
CMD /init.sh

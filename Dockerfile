FROM alpine:edge

# get packages we need
RUN apk update && \
    apk add --no-cache ca-certificates caddy wget && \
    rm -rf /var/cache/apk/*

# set up files
RUN mkdir -p /etc/caddy /usr/share/caddy
COPY files/caddy.conf /etc/caddy/caddy.conf
COPY files/index.html /usr/share/caddy/index.html
COPY files/jump.json /jump.json
COPY files/xp /xp

# init
ADD init.sh /init.sh
RUN chmod +x /init.sh
CMD /init.sh

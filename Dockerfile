FROM alpine:edge

# get packages we need
RUN apk update && \
    apk add --no-cache ca-certificates caddy wget && \
    rm -rf /var/cache/apk/*

# set up files
RUN mkdir -p /etc/caddy /usr/share/caddy
COPY caddy.conf /etc/caddy/caddy.conf
COPY index.html /usr/share/caddy/index.html
COPY xp /xp

# init
COPY init.sh /init.sh
RUN chmod +x /init.sh
CMD /init.sh

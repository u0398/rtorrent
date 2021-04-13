FROM alpine:3.13
LABEL maintainer="u0398 <u0398@gmail.com>"

# Install rtorrent and su-exec
RUN apk add --no-cache \
      rtorrent \
      su-exec && \
    # Create necessary folders
    mkdir -p \
      /dist \
      /config \
      /session \
      #/socket \
      /watch/load \
      /watch/start \
      /downloads && \
    # Forward Info & Error logs to std{out,err} (à la nginx)
    ln -sf /dev/stdout /var/log/rtorrent-info.log && \
    ln -sf /dev/stderr /var/log/rtorrent-error.log

#VOLUME ["/config", "/session", "/socket", "/watch", "/downloads"]
VOLUME ["/config", "/session", "/watch", "/downloads"]

# Copy distribution rTorrent config for bootstrapping and entrypoint
COPY ./root /

ENTRYPOINT ["/entrypoint"]

CMD ["rtorrent", "-n", "-o", "import=/config/.rtorrent.rc"]

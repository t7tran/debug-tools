FROM alpine:3.15

COPY --chown=1000:1000 entrypoint.sh /

RUN addgroup -g 1000 alpine && adduser -u 1000 -s /bin/sh -D -G alpine alpine && \
    chmod u+x /entrypoint.sh && \
    apk add --no-cache bash curl openssl && \
    rm -rf /apk /tmp/* /var/cache/apk/* /sbin/*

USER alpine

ENTRYPOINT ["/entrypoint.sh"]
CMD []